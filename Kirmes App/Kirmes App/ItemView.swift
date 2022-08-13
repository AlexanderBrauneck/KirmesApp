//
//  ItemView.swift
//  Kirmes App
//

import SwiftUI


struct ItemView: View {
    let viewModel: KirmesViewModel
    let item: FrontendKirmesItem
        
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
                    NameAndPriceView(item: item)
                    Text(String(item.anzahl))
                        .font(DrawingConstants.font(
                            size: geometry.size,
                            fontSize:DrawingConstants.itemAnzahlFontSize))
                        .frame(
                            width: geometry.size.width/DrawingConstants.anzahlSpace,
                            height: geometry.size.height,
                            alignment: .trailing)
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

struct NameView: View {
    let name: String
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(name)
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomLeading)
                    .font(DrawingConstants.font(
                        size: geometry.size,
                        fontSize: DrawingConstants.itemNameFontSize))
                Spacer()
            }
        }
    }
}

struct PriceView: View {
    let price: Int
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(String(format: "%.2f €",Float(price) / 100))
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
                    .font(DrawingConstants.font(
                        size: geometry.size,
                        fontSize: DrawingConstants.itemPriceFontSize))
                Spacer()
            }
        }
    }
}

struct NameAndPriceView: View {
    let item: FrontendKirmesItem
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NameView(name: item.name).frame(height: geometry.size.height/2 , alignment: .bottomLeading)
                PriceView(price: item.price).frame(height: geometry.size.height/2, alignment: .topLeading)
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
    
    //ItemView
    static let itemCornerRadius: CGFloat = 15
    static let horizontalItemSpace: CGFloat = 40
    static let plusMinusButtonSize: CGFloat = 0.35
    static let plusMinutButtonWidth: CGFloat = 80
    static let anzahlSpace: CGFloat = 7

    //Font
    static let itemAnzahlFontSize: CGFloat = 0.26
    static let itemNameFontSize: CGFloat = 0.5
    static let itemPriceFontSize: CGFloat = 0.35
    static func font(size: CGSize, fontSize: CGFloat) -> Font {
        Font.system(size: min(size.width, size.height) * fontSize)
    }
}













struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(
            viewModel: KirmesViewModel(),
            item: FrontendKirmesItem(
                id: 0,
                name: "HalloTest",
                price: 233,
                color: .systemOrange,
                anzahl: 99))
        .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
