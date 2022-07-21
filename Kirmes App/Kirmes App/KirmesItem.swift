//
//  KirmesItem.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 29.06.22.
//

import Foundation
import SwiftUI


struct KirmesItem: Identifiable, Codable{
    var id: Int
    var name: String
    var preis: Double
    var farbe: String
    var anzahl: Int
    
    
    init(id: Int, name: String, preis: Double, farbe: String) {
        self.id = id
        self.name = name
        self.preis = preis
        self.farbe = farbe
        self.anzahl = 0
    }
}

