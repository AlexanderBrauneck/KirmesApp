//
//  KirmesItem.swift
//  Kirmes App
//

import Foundation

enum BackendKirmesItemsEnum: Codable {
    case kirmesItemArray([BackendKirmesItem])
    case purpleKirmesItem(BackendKirmesItems)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([BackendKirmesItem].self) {
            self = .kirmesItemArray(x)
            return
        }
        if let x = try? container.decode(BackendKirmesItems.self) {
            self = .purpleKirmesItem(x)
            return
        }
        throw DecodingError.typeMismatch(EverythingFromBackendKirmesItems.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for BackendKirmesItemsEnum"))
    }
}

struct BackendKirmesItem: Codable, Identifiable {
    let id: Int
    let name: String
    let price: Int
    let colorhex, comment: String
}

struct BackendKirmesItems: Codable {
    var kirmesItems: [BackendKirmesItem]
}

typealias EverythingFromBackendKirmesItems = [BackendKirmesItemsEnum]
