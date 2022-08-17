//
//  FrontendKirmesItem.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 07.08.22.
//

import Foundation
import SwiftUI


struct FrontendKirmesItem: Identifiable{
    let id: Int
    let name: String
    let price: Int
    let color: UIColor
    var anzahl: Int
    
}

struct FrontendKirmesItems {
    var kirmesItems: [FrontendKirmesItem]
}
