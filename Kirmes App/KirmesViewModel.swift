//
//  File.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 27.06.22.
//

import SwiftUI


class KirmesViewModel: ObservableObject {
/*  Hier kommt kommunikation zwischen model und view rein
    Ändert daten des Models
    vllt greift das hier auf zwei models zu, eins für die logik eins für die daten
    eig nich notwendig
*/
    @Published private var model: KirmesModel = KirmesModel()
    
    var allItems: Array<KirmesItem> {
        model.allItems
    }
    
    func add(_ item: KirmesItem){
        model.add(item)
    }
    
    func remove(_ item: KirmesItem){
        model.remove(item)
    }
    
    func abschicken() {
        model.abschicken()
    }
    
    
    
}

