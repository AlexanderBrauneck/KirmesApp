//
//  KirmesModel.swift
//  Kirmes App
//

import Foundation
import SwiftUI
import Combine

struct KirmesModel {
    
//    let itemsUrl = URL(string: "http://192.168.0.101:7000/kirmes/items")
//    let url = URL(string: "http://192.168.0.101:7000/kirmes/quittung")
    private var cancellable = [AnyCancellable]()
    var itemList: FrontendKirmesItems = FrontendKirmesItems(kirmesItems: [])
    var allesVonDerUrl: BackendKirmesItemsEnum = .purpleKirmesItem(BackendKirmesItems(kirmesItems: []))
    var itemsForReceipt: FrontendKirmesItems = FrontendKirmesItems(kirmesItems: [])
    var summe: Int = 0
    
    func loadKirmesItems(urlToExecute: URL, completionHandler: @escaping (EverythingFromBackendKirmesItems, Error?) -> Void) {
        
        let sharedSession = URLSession.shared
        let webRequest = URLRequest(url: urlToExecute)
        let decoder = JSONDecoder()
        
        let dataTask = sharedSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            guard let unwrappedData = webData else {
                completionHandler([], apiError)
                return
            }
            do {
                // MARK: Hier
                let jsonResponse = try decoder.decode(EverythingFromBackendKirmesItems.self, from: unwrappedData)
                completionHandler(jsonResponse, nil)
            } catch {
                print(String(describing: error))
                completionHandler([], error)
            }
        }
        dataTask.resume()
    }
    
    //plus
    mutating func add(_ item: FrontendKirmesItem) {
        itemList.kirmesItems[item.id].anzahl += 1
    }
    
    //minus
    mutating func remove(_ item: FrontendKirmesItem) {
        if itemList.kirmesItems[item.id].anzahl >= 1 {
            itemList.kirmesItems[item.id].anzahl -= 1
        }
    }
    
    mutating func summeBerechnen() -> Int{
        summe = 0
        for item in itemList.kirmesItems {
            summe += (item.price*item.anzahl)
        }
        return summe
    }
    
    mutating func zahlen(urlToExecute: URL) -> FrontendKirmesItems {
        itemsForReceipt = FrontendKirmesItems(kirmesItems: [])
        quittungZumBackend(urlToExecute: urlToExecute, upLoadData: quittungSchreiben(frontendKirmesItems: itemList))
        for item in itemList.kirmesItems {
            itemsForReceipt.kirmesItems.append(FrontendKirmesItem(
                id: item.id,
                name: item.name,
                price: item.price,
                color: item.color,
                anzahl: 0))
        }
        return itemsForReceipt
    }
    
    func quittungZumBackend(urlToExecute: URL, upLoadData: Array<String>) {
        var request = URLRequest(url: urlToExecute)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let encodedData = try JSONEncoder().encode(upLoadData)
            let uploadTask = URLSession.shared.uploadTask(with: request, from: encodedData) { data, response, error in
                if let error = error {
                    print("error: \(error)")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print ("server error")
                    return
                }
                if let mimeType = response.mimeType,
                   mimeType == "application/json",
                   let data = data,
                   let dataString = String(data: data, encoding: .utf8) {
                    print("got data: \(dataString)")
                } else {
                    print("something went wrong")
                }

                
            }
            uploadTask.resume()
        } catch {
            print("Quittung abschicken fehlgeschlagen")
        }
    }
    
    func quittungSchreiben(frontendKirmesItems: FrontendKirmesItems) -> Array<String> {
        var ergebnis: Array<String> = []
        for item in frontendKirmesItems.kirmesItems {
            if frontendKirmesItems.kirmesItems[item.id].anzahl > 0 {
                ergebnis.append(String(frontendKirmesItems.kirmesItems[item.id].anzahl) + " " + frontendKirmesItems.kirmesItems[item.id].name)
                print(String(frontendKirmesItems.kirmesItems[item.id].anzahl) + " " + frontendKirmesItems.kirmesItems[item.id].name)
            }
        }
        return ergebnis
    }
    
    mutating func ausBackMachFrontKirmesItems(backendKirmesItems: BackendKirmesItems) -> FrontendKirmesItems{
        var newKirmesItems = FrontendKirmesItems(kirmesItems: [])
        for item in backendKirmesItems.kirmesItems {
            newKirmesItems.kirmesItems.append(FrontendKirmesItem(
                id: item.id,
                name: item.name,
                price: item.price,
                color: hexStringToUIColor(hex: item.colorhex),
                anzahl: 0))
        }
        return newKirmesItems
    }
                                              
    func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(0.7)
        )
    }
}















