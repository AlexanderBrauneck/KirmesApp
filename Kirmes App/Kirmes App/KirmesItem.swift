//
//  KirmesItem.swift
//  Kirmes App
//

import Foundation

enum KirmesItemUnion: Codable {
    case kirmesItemArray([KirmesItem])
    case purpleKirmesItem(PurpleKirmesItem)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([KirmesItem].self) {
            self = .kirmesItemArray(x)
            return
        }
        if let x = try? container.decode(PurpleKirmesItem.self) {
            self = .purpleKirmesItem(x)
            return
        }
        throw DecodingError.typeMismatch(KirmesItemUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for KirmesItemUnion"))
    }
}

struct KirmesItem: Codable, Identifiable {
    let id: Int
    let name: String
    let price: Int
    let colorhex, comment: String
}

struct PurpleKirmesItem: Codable {
    var kirmesItems: [KirmesItem]
}

typealias KirmesItems = [KirmesItemUnion]
