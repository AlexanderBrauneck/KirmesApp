//
//  KirmesItem.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 29.06.22.
//

import Foundation
import SwiftUI


struct KirmesItem: Identifiable{
    var id: Int
    var name: String
    var preis: Double
    var farbe: Color
    var anzahl: Int
    
    
    init(id: Int, name: String, preis: Double, farbe: Color) {
        self.id = id
        self.name = name
        self.preis = preis
        self.farbe = farbe
        self.anzahl = 0
    }
}

