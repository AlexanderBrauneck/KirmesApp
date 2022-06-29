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
    
    // Dummy Daten, TODO: Daten aus Backend lesen
    static var item1 = KirmesItem(id: 0, name: "Bier", preis: 12.34, farbe: Color.red)
    static var item2 = KirmesItem(id: 1, name: "Cola", preis: 7.89, farbe: Color.blue)
    static var item3 = KirmesItem(id: 2, name: "Käse", preis: 9.87, farbe: Color.yellow)
    static var item4 = KirmesItem(id: 3, name: "Brezel", preis: 5.64, farbe: Color.green)
    var allItems = [item1, item2, item3, item4]
    
    
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
    func abschicken() {
        print("Abschicken gedrückt")
    }
    
    
    
    
}





