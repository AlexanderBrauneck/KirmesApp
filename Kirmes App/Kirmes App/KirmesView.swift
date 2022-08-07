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
                    .frame(width: geometry.size.width * DrawingConstants.contentSideSpace)
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
    
    //TODO: Summe und Popup mit geld zurück dies das
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.bottomBarCornerRadius)
                    .foregroundColor(Color.black.opacity(DrawingConstants.bottomBarOpacity))
                HStack {
                    Text("Summe: " + String(format: "%.2f €", Float(summe) / 100))
                        .font(summeFont(in: geometry.size))
                    Spacer()
                    Button(action: {viewModel.zahlen()}) {
                        Text("Abschicken").font(summeFont(in: geometry.size))
                    }
                }
            }.padding()
        }
    }
    private func summeFont(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * DrawingConstants.summeFontSize)
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
                        Text(item.name).font(itemNameFont(in: geometry.size)).padding()
                        Text(String(format: "%.2f €",Float(item.price) / 100)).font(itemPriceFont(in: geometry.size))
                    }
                    Spacer()
                    Text(String(item.anzahl)).font(itemNameFont(in: geometry.size))
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
    private func itemNameFont(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * DrawingConstants.itemNameFontSize)
    }
    private func itemPriceFont(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.width) * DrawingConstants.itemPriceFontSize)
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
    static let itemCornerRadius: CGFloat = 15
    static let itemNameFontSize: CGFloat = 0.08
    static let itemPriceFontSize: CGFloat = 0.06
    static let summeFontSize: CGFloat = 0.07
    static let backgroundColor: UIColor = UIColor.systemOrange.withAlphaComponent(0.15)
    static let plusMinusButtonSize: CGFloat = 0.4
    static let plusMinutButtonWidth: CGFloat = 80
    static let contentSideSpace: CGFloat = 0.95
    static let bottomBarSpace: CGFloat = 0.85
    static let horizontalItemSpace: CGFloat = 40
    static let bottomBarOpacity: CGFloat = 0.0
    static let bottomBarCornerRadius: CGFloat = 0.0
}

























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = KirmesViewModel()
        KirmesView(viewModel: viewModel)
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

