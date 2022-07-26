//
//  KirmesModel.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 29.06.22.
//

import Foundation
import SwiftUI


// Hier passiert die Logik also plus minus oder was?
// Hier sind die Daten und die anbindung ans backend

struct KirmesModel {
    
    var allItems: Array<KirmesItem> = []
    
    mutating func loadKirmesItems() async {
        guard let url = URL(string: "https://localhost:7000/kirmes/items") else { return debugPrint("No URL found") }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(KirmesItems.self, from: data) {
                allItems = decodedResponse.kirmesItems
            }
        } catch {
            print("Invalid data")
            // Aktueller Stand, weil wahrscheinlich die daten im backend kein json is
        }
        
    }
    
    // Dummy Daten, TODO: Daten aus Backend lesen
//    static var item1 = KirmesItem(id: 0, name: "Bier", preis: 12.34, farbe: "")
//    static var item2 = KirmesItem(id: 1, name: "Cola", preis: 7.89, farbe: "")
//    static var item3 = KirmesItem(id: 2, name: "Käse", preis: 9.87, farbe: "")
//    static var item4 = KirmesItem(id: 3, name: "Brezel", preis: 5.64, farbe: "")
//    var allItems = [item1, item2, item3, item4]
    var itemsForReceipt: Array<KirmesItem> = []

    
    //plus
    mutating func add(_ item: KirmesItem) {
        // das geht besser mit if denk ich mal
        allItems[item.id].anzahl += 1
    }
    
    //minus
    mutating func remove(_ item: KirmesItem) {
        if allItems[item.id].anzahl >= 1 {
            allItems[item.id].anzahl -= 1
        }
    }
    
    //abschicken, TODO: Daten schreiben ins Backend
    mutating func abschicken() -> Array<KirmesItem> {
        print("Abschicken gedrückt")
        itemsForReceipt = []
        for item in allItems {
            itemsForReceipt.append(KirmesItem(id: item.id, name: item.name, preis: item.preis, farbe: item.farbe))
        }
        return itemsForReceipt
    }
    
    
    
    
}





