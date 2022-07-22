//
//  ContentView.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 15.06.22.
//

import SwiftUI

struct KirmesView: View {
    @ObservedObject var viewModel: KirmesViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.allItems) { item in
                ItemView(viewModel: viewModel, item: item)
            }
            Spacer()
            Button(action: {viewModel.abschicken()}) {
                Text("Abschicken")
            }
            //TODO: Summe und overlay mit geld zurück dies das
        }.task {
            await viewModel.loadKirmesItems()
        }
    }
}

struct ItemView: View {
    let viewModel: KirmesViewModel
    let item: KirmesItem
    
    //TODO: Buttons und Text größer und schöner / besser klickbar
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                shape.fill().foregroundColor(.yellow)
                HStack {
                    remove
                    Spacer()
                    Text(item.name).font(font(in: geometry.size))
                    Spacer()
                    Text("\(item.anzahl)")
                    Spacer()
                    add
                }
            }
        }
    }
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * 0.1)
    }

    var remove: some View {
        Button(action: { viewModel.remove(item) }, label: {Image(systemName: "minus.circle")})
    }

    var add: some View {
        Button(action: { viewModel.add(item) }, label: {Image(systemName: "plus.circle")})
    }
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KirmesViewModel()
        KirmesView(viewModel: viewModel)
    }
}

