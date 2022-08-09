//
//  ContentView.swift
//  Kirmes App
//

import SwiftUI

struct KirmesView: View {
    @ObservedObject var viewModel: KirmesViewModel
    
    @State var showingPopup = false
    
    var body: some View {
        ZStack {
            Color.init(DrawingConstants.backgroundColor).ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    VStack {
                        //zum testen
//                        ForEach(0..<4) { _ in
//                            ItemView(
//                                viewModel: viewModel,
//                                item: FrontendKirmesItem(
//                                    id: 1,
//                                    name: "Hallo",
//                                    price: 199,
//                                    color: .systemOrange,
//                                    anzahl: 0
//                                )
//                            )
//                        }
                        //test ende
                        ForEach(viewModel.allItems.kirmesItems) { item in
                            ItemView(viewModel: viewModel, item: item)
                        }
                    }
                    .frame(width: geometry.size.width * DrawingConstants.bottomBarContentSideSpace)
                    .frame(height: geometry.size.height * DrawingConstants.bottomBarSpace, alignment: .topLeading)
                    .task {
                        await viewModel.loadKirmesItems()
                    }
                    BottomBarView(summe: viewModel.summe, viewModel: viewModel)
                }
            }
        }
    }
}

struct BottomBarView: View {
    let summe: Int
    let viewModel: KirmesViewModel
    @State var showingPopup = false
    
    //TODO: Summe und Popup mit geld zurück dies das
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.bottomBarCornerRadius)
                    .foregroundColor(Color.black.opacity(DrawingConstants.bottomBarOpacity))
                HStack {
                    Text("Summe: " + String(format: "%.2f €", Float(summe) / 100))
                        .font(DrawingConstants.font(
                            size: geometry.size,
                            fontSize: DrawingConstants.summeFontSize))
                    Spacer()
                    Button(action: { showingPopup = true }) {
                        Text("Zahlen").font(DrawingConstants.font(
                            size: geometry.size,
                            fontSize: DrawingConstants.summeFontSize))
                    }.popover(isPresented: $showingPopup){
                        PopupView(isShowing: $showingPopup, viewModel: viewModel)
                    }
                }
            }.padding()
        }
    }
}

struct ItemView: View {
    let viewModel: KirmesViewModel
    let item: FrontendKirmesItem
    
    //TODO: Buttons und Text größer und schöner / besser klickbar
    
    var body: some View {
        GeometryReader { geometry in
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.itemCornerRadius)
            shape.fill().foregroundColor(Color(item.color))
            ZStack {
                HStack {
                    PlusMinusButton(
                        item: item,
                        action: viewModel.remove(_:),
                        plusOrMinus: "minus.circle",
                        geometry: geometry
                    )
                    VStack {
                        Text(item.name)
                            .font(DrawingConstants.font(
                                size: geometry.size,
                                fontSize: DrawingConstants.itemNameFontSize))
                            .padding()
                        Text(String(format: "%.2f €",Float(item.price) / 100))
                            .font(DrawingConstants.font(
                                size: geometry.size,
                                fontSize: DrawingConstants.itemPriceFontSize))
                    }
                    Spacer()
                    Text(String(item.anzahl))
                        .font(DrawingConstants.font(
                            size: geometry.size,
                            fontSize: DrawingConstants.itemNameFontSize))
                        .frame(height: geometry.size.height)
                        .frame(alignment: .center)
                    PlusMinusButton(
                        item: item,
                        action: viewModel.add(_:),
                        plusOrMinus: "plus.circle",
                        geometry: geometry
                    )
                }
            }
        }
    }
}

struct PlusMinusButton: View {
    let item: FrontendKirmesItem
    let action: (FrontendKirmesItem) -> ()
    let plusOrMinus: String
    let geometry: GeometryProxy
    
    var body: some View {
        Button(
            action: { action(item) },
            label: {
                Image(systemName: plusOrMinus)
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * DrawingConstants.plusMinusButtonSize)
                    .frame(width: DrawingConstants.plusMinutButtonWidth, height: geometry.size.height, alignment: .center)
            }
        )
    }
}

private struct DrawingConstants {
    static let backgroundColor: UIColor = UIColor.systemOrange.withAlphaComponent(0.15)
    
    //BottomBar
    static let bottomBarOpacity: CGFloat = 0.0
    static let bottomBarCornerRadius: CGFloat = 0.0
    static let bottomBarSpace: CGFloat = 0.85
    static let bottomBarContentSideSpace: CGFloat = 0.95

    //ItemView
    static let itemCornerRadius: CGFloat = 15
    static let horizontalItemSpace: CGFloat = 40
    static let plusMinusButtonSize: CGFloat = 0.4
    static let plusMinutButtonWidth: CGFloat = 80

    //PopupView
    static let closeButtonSize: CGFloat = 30
    
    //Font
    static let itemNameFontSize: CGFloat = 0.08
    static let itemPriceFontSize: CGFloat = 0.06
    static let summeFontSize: CGFloat = 0.07
    static func font(size: CGSize, fontSize: CGFloat) -> Font {
        Font.system(size: min(size.width, size.width) * fontSize)
    }
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KirmesViewModel()
        KirmesView(viewModel: viewModel)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

