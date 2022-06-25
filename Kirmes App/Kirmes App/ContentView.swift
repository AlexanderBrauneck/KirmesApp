//
//  ContentView.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 15.06.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ItemView()
            ItemView()
            ItemView()
            ItemView()
            ItemView()
            Spacer()
        }
    }
}

struct ItemView: View {
    @State var itemCount: Int = 0
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            shape.fill().foregroundColor(.yellow)
            HStack {
                remove
                Spacer()
                Text("Bier")
                Text("\(itemCount)")
                Spacer()
                add
            }
        }
    }
    
    var remove: some View {
        Button(action: { if itemCount >= 1 { itemCount -= 1 } }, label: {Image(systemName: "minus.circle")})
    }
    
    var add: some View {
        Button(action: { itemCount += 1 }, label: {Image(systemName: "plus.circle")})
    }
    
    
}


























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

