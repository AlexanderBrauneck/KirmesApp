//
//  File.swift
//  Kirmes App
//

import SwiftUI


class KirmesViewModel: ObservableObject {

    @Published private var model: KirmesModel = KirmesModel()
    let url = URL(string: "http://192.168.0.101:7000/kirmes/items")

    var allItems: PurpleKirmesItem {
        model.itemList
    }
    
    func add(_ item: KirmesItem){
        model.add(item)
    }
    
    func remove(_ item: KirmesItem){
        model.remove(item)
    }
    
    func abschicken() {
   //     model.itemList = model.abschicken()
    }
    
    func loadKirmesItems() async {
        model.loadKirmesItems(urlToExecute: url!) { (responseDict, error) in
            DispatchQueue.main.async { [self] in
                if let unwrappedError = error {
                    print(String(describing: unwrappedError))
                }
                model.allesVonDerUrl = responseDict[1]
                switch model.allesVonDerUrl {
                case .purpleKirmesItem(let purpleItem):
                    model.itemList.kirmesItems = purpleItem.kirmesItems
                case .kirmesItemArray(let kirmesArray):
                    model.itemList.kirmesItems = kirmesArray
                }
            }
        }
    }
}

