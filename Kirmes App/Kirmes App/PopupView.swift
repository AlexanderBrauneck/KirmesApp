//
//  SwiftUIView.swift
//  Kirmes App
//
//  Created by Anna Reyhe on 09.08.22.
//

import SwiftUI

struct PopupView: View {
    @Binding var isShowing: Bool
    var viewModel: KirmesViewModel
    @State var payed: Int = 0
    let numberFormatter: NumberFormatter
    
    init(isShowing: Binding<Bool>, viewModel: KirmesViewModel) {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        numberFormatter.maximumFractionDigits = 2
        self._isShowing = isShowing
        self.viewModel = viewModel
        
        
    }
        
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color.init(DrawingConstants.backgroundColor).ignoresSafeArea()
                CloseView(isShowing: $isShowing, value: $payed)
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0)
                        .fixedSize()
                        .frame(
                            minWidth: geometry.size.width * DrawingConstants.fertigButtonWidth,
                            minHeight: geometry.size.height * DrawingConstants.fertigButtonHeight)

                    Text("Test oke das sieht schon ganz gut aus")
                    CurrencyTextField(numberFormatter: numberFormatter, value: $payed, placeholder: "0.00 €")
                        .padding(20)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                        .frame(height: 100)
                    Divider()
                    Text("Rückgeld: " + String(
                        format: "%.2f €",
                        Float((Int(payed) - viewModel.summe)) / 100))
                    FertigButton(isShowing: $isShowing, viewModel: viewModel, geometry: geometry)
                }.padding()
            }
        }
    }
}

struct FertigButton: View {
    @Binding var isShowing: Bool
    var viewModel: KirmesViewModel
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            HStack {

        Button(action: {
            viewModel.zahlen()
            isShowing = false
        }) {
                    ZStack {
                        Text("Fertig").font(.largeTitle).foregroundColor(.black)
                        RoundedRectangle(cornerRadius: DrawingConstants.fertigButtonCornerRadius)
                            .foregroundColor(Color(DrawingConstants.fertigButtonColor).opacity(0.5))
                            .frame(
                                minWidth: geometry.size.width * DrawingConstants.fertigButtonWidth,
                                minHeight: geometry.size.height * DrawingConstants.fertigButtonHeight)
                    }.fixedSize()
                }
            }
            Spacer()
        }
    }
}

struct CloseView: View {
    @Binding var isShowing: Bool
    @Binding var value: Int
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button( action: { isShowing = false } ) {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: DrawingConstants.closeButtonSize,
                            height: DrawingConstants.closeButtonSize,
                            alignment: .topTrailing)
                }.padding()
            }
            Spacer()
        }
    }
}



private struct DrawingConstants {
    static let backgroundColor: UIColor = UIColor.systemOrange.withAlphaComponent(0.1)
    //Font
    static let textFieldFont: CGFloat = 0.15
    static func font(size: CGSize, fontSize: CGFloat) -> Font {
        Font.system(size: min(size.width, size.width) * fontSize)
    }
    
    //PopupView
    static let closeButtonSize: CGFloat = 30
    
    //FertigButton
    static let fertigButtonCornerRadius: CGFloat = 15
    static let fertigButtonColor: UIColor = .systemBlue
    static let fertigButtonWidth: CGFloat = 0.8
    static let fertigButtonHeight: CGFloat = 0.13
}





















struct PopupViewPreviewContainer: View {
    @State private var isShowing = true
    @State private var payed = "0"
    let viewModel = KirmesViewModel()
    
    var body: some View {
        PopupView(isShowing: $isShowing, viewModel: viewModel)
    }
    
}

struct PopupViewPreview: PreviewProvider {
    static var previews: some View {
        PopupViewPreviewContainer()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
