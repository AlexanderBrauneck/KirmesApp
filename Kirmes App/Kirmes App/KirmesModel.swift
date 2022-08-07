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
    var itemList: PurpleKirmesItem = PurpleKirmesItem(kirmesItems: [])
    var allesVonDerUrl: KirmesItemUnion = .purpleKirmesItem(PurpleKirmesItem(kirmesItems: []))
    var itemsForReceipt: KirmesItems = []
    
    func loadKirmesItems(urlToExecute: URL, completionHandler: @escaping (KirmesItems, Error?) -> Void) {
        
        let sharedSession = URLSession.shared
        let webRequest = URLRequest(url: urlToExecute)
        let decoder = JSONDecoder()
        
        let dataTask = sharedSession.dataTask(with: webRequest) { (webData, urlResponse, apiError) in
            guard let unwrappedData = webData else {
                completionHandler([], apiError)
                return
            }
            do {
                let jsonResponse = try decoder.decode(KirmesItems.self, from: unwrappedData)
                completionHandler(jsonResponse, nil)
            } catch {
                print(String(describing: error))
                completionHandler([], error)
            }
        }
        dataTask.resume()
    }
    
    //plus
    mutating func add(_ item: KirmesItem) {
//        // das geht besser mit if denk ich mal
//        itemList[item.id].anzahl += 1
    }
    
    //minus
    mutating func remove(_ item: KirmesItem) {
//        if itemList[item.id].anzahl >= 1 {
//            itemList[item.id].anzahl -= 1
//        }
    }
    
    //abschicken, TODO: Daten schreiben ins Backend
    mutating func abschicken() -> KirmesItems {
        print("Abschicken gedrückt")
        itemsForReceipt = []
        for item in itemList.kirmesItems {
//            itemsForReceipt.append(KirmesItem(id: item.id, name: item.name, price: item.price, colorhex: item.colorhex, comment: item.comment))
        }
        return itemsForReceipt
    }
}
