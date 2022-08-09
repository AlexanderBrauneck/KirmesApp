//
//  KirmesModel.swift
//  Kirmes App
//

import Foundation
import SwiftUI
import Combine

struct KirmesModel {
    
    let url = URL(string: "http://192.168.0.101:7000/kirmes/items")
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
        //print("Summe ist: \(summe)")
    }
    
    //zahlen, TODO: Daten schreiben ins Backend
    mutating func zahlen() -> FrontendKirmesItems {
        print("Abschicken gedrückt")
        itemsForReceipt = FrontendKirmesItems(kirmesItems: [])
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















