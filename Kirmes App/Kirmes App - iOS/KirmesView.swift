//
//  ContentView.swift
//  Kirmes App
//

import SwiftUI

struct KirmesView: View {
    @ObservedObject var viewModel: KirmesViewModel
        
    var body: some View {
        ZStack {
            Color.init(DrawingConstants.backgroundColor).ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    VStack {
                        // MARK: zum testen ende
                        ForEach(viewModel.allItems.kirmesItems) { item in
                            ItemView(viewModel: viewModel, item: item)
                        }
                    }
                    .task {
                        await viewModel.loadKirmesItems()
                    }
                    BottomBarView(summe: viewModel.summe, viewModel: viewModel)
                        .frame(height: geometry.size.height * DrawingConstants.bottomBarSize)
                }.frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
            }
        }
    }
}

struct BottomBarView: View {
    let summe: Int
    let viewModel: KirmesViewModel
    @State var showingPopup = false
    @State var orientation = UIDeviceOrientation.unknown
        
    var body: some View {
        
        GeometryReader { geometry in
            HStack {
                Text("Summe: " + String(format: "%.2f €", Float(summe) / 100))
                    .scaledToFit()
                    .font(DrawingConstants.font(
                        size: geometry.size,
                        fontSize: DrawingConstants.summeFontSize))
                Spacer()
                Button(action: { showingPopup = true }) {
                    Text("Zahlen").font(DrawingConstants.font(
                        size: geometry.size,
                        fontSize: DrawingConstants.summeFontSize))
                }.sheet(isPresented: $showingPopup){
                    PopupView(isShowing: $showingPopup, viewModel: viewModel, orientation: $orientation)
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
    }
}


private struct DrawingConstants {
    static let backgroundColor: UIColor = UIColor.systemOrange.withAlphaComponent(0.15)
    
    //BottomBar
    static let bottomBarSize: CGFloat = 0.15
    
    //Font
    static let summeFontSize: CGFloat = 0.3
    static func font(size: CGSize, fontSize: CGFloat) -> Font {
        Font.system(size: min(size.width, size.height) * fontSize)
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KirmesViewModel()
        KirmesView(viewModel: viewModel)
            .previewInterfaceOrientation(.portrait)
    }
}

