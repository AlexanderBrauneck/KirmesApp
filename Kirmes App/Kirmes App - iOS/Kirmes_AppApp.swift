//
//  Kirmes_AppApp.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 15.06.22.
//

import SwiftUI

@main
struct Kirmes_AppApp: App {
    let viewModel = KirmesViewModel()
    
    var body: some Scene {
        WindowGroup {
            KirmesView(viewModel: viewModel)
        }
    }
}
