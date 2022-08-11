//
//  File.swift
//  Kirmes App
//

import SwiftUI


class KirmesViewModel: ObservableObject {

    @Published private var model: KirmesModel = KirmesModel()
    let kirmesUrl = URL(string: "http://192.168.0.101:7000/kirmes/items")
    let quittungUrl = URL(string: "http://192.168.0.101:7000/kirmes/quittung")

    var allItems: FrontendKirmesItems {
        model.itemList
    }
    
    var summe: Int {
        model.summe
    }
    
    func add(_ item: FrontendKirmesItem){
        model.add(item)
        model.summe = model.summeBerechnen()
    }
    
    func remove(_ item: FrontendKirmesItem){
        model.remove(item)
        model.summe = model.summeBerechnen()
    }
    
    func zahlen() {
        model.itemList = model.zahlen(urlToExecute: quittungUrl!)
        model.summe = model.summeBerechnen()
    }
    
    func loadKirmesItems() async {
        model.loadKirmesItems(urlToExecute: kirmesUrl!) { (responseDict, error) in
            DispatchQueue.main.async { [self] in
                if let unwrappedError = error {
                    print(String(describing: unwrappedError))
                }
                model.allesVonDerUrl = responseDict[1]
                switch model.allesVonDerUrl {
                case .purpleKirmesItem(let purpleItem):
                    model.itemList = model.ausBackMachFrontKirmesItems(backendKirmesItems: purpleItem)
                case .kirmesItemArray(_):
                    print("Error KirmesArray was found")
                }
            }
        }
    }
}
