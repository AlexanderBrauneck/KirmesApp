//
//  SwiftUIView.swift
//  Kirmes App
//

import SwiftUI

struct PopupView: View {
    @Binding var isShowing: Bool
    var viewModel: KirmesViewModel
    @State var payed: Int = 0
    let numberFormatter: NumberFormatter
    @Binding private var orientation: UIDeviceOrientation
    
    init(isShowing: Binding<Bool>, viewModel: KirmesViewModel, orientation: Binding<UIDeviceOrientation>) {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "€"
        numberFormatter.maximumFractionDigits = 2
        self._isShowing = isShowing
        self.viewModel = viewModel
        self._orientation = orientation
    }
        
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color.init(DrawingConstants.backgroundColor).ignoresSafeArea()
                VStack {
                    HStack {
                        FertigButton(isShowing: $isShowing, viewModel: viewModel).padding()
                        Spacer()
                        CloseView(isShowing: $isShowing, value: $payed)
                    
                    }
                    Group {
                        if orientation.isLandscape {
                            HStack {
                                GegebenRückgeldView(geometry: geometry, payed: $payed, viewModel: viewModel, numberFormatter: numberFormatter)
                            }.padding()
                        } else if orientation.isPortrait{
                            VStack {
                                GegebenRückgeldView(geometry: geometry, payed: $payed, viewModel: viewModel, numberFormatter: numberFormatter)
                            }.padding()
                        } else {
                            VStack {
                                GegebenRückgeldView(geometry: geometry, payed: $payed, viewModel: viewModel, numberFormatter: numberFormatter)
                            }.padding()
                        }
                    }.onRotate { newOrientation in
                        orientation = newOrientation
                    }
                }
            }
        }
    }
}

struct GegebenRückgeldView: View {
    let geometry: GeometryProxy
    @Binding var payed: Int
    let viewModel: KirmesViewModel
    let numberFormatter: NumberFormatter
    
    
    var body: some View {
        Divider()
        HStack {
            Text("Gegeben:").font(DrawingConstants.font(size: geometry.size, fontSize: DrawingConstants.popupViewFont)).padding()
        Spacer()
            CurrencyTextField(numberFormatter: numberFormatter, value: $payed, placeholder: "0.00 €")
                .padding(8)
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2))
                .frame(height: geometry.size.height * DrawingConstants.textFieldHeigt)
        }
        Divider()
        HStack {
            Text("Rückgeld:")
                .font(DrawingConstants.font(
                    size: geometry.size,
                    fontSize: DrawingConstants.popupViewFont))
                .padding()
            Spacer()
            Text(String(format: "%.2f €",Float((Int(payed) - viewModel.summe)) / 100))
                .font(DrawingConstants.font(
                    size: geometry.size,
                    fontSize: DrawingConstants.popupViewFont))
                .padding()
        }
        Spacer()

    }
}


struct FertigButton: View {
    @Binding var isShowing: Bool
    var viewModel: KirmesViewModel
    
    var body: some View {
        Button(action: {
            viewModel.zahlen()
            isShowing = false
        }) {
            Text("Fertig").font(.largeTitle).bold()
        }
    }
}

struct CloseView: View {
    @Binding var isShowing: Bool
    @Binding var value: Int
    
    var body: some View {
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
}



private struct DrawingConstants {
    static let backgroundColor: UIColor = UIColor.systemOrange.withAlphaComponent(0.1)
    static let textFieldHeigt: CGFloat = 0.05
    
    //Font
    static let textFieldFont: CGFloat = 0.15
    static let fertigFontSize: CGFloat = 0.6
    static let popupViewFont: CGFloat = 0.08
    static func font(size: CGSize, fontSize: CGFloat) -> Font {
        Font.system(size: min(size.width, size.height) * fontSize)
    }
    
    //PopupView
    static let closeButtonSize: CGFloat = 30
    
    //FertigButton
    static let fertigButtonCornerRadius: CGFloat = 15
    static let fertigButtonColor: UIColor = .systemBlue
    static let fertigButtonWidth: CGFloat = 0.7
    static let fertigButtonHeight: CGFloat = 100
}





















struct PopupViewPreviewContainer: View {
    @State private var isShowing = true
    @State private var payed = "0"
    @State private var orientation = UIDeviceOrientation.unknown
    let viewModel = KirmesViewModel()
    
    var body: some View {
        PopupView(isShowing: $isShowing, viewModel: viewModel, orientation: $orientation)
    }
    
}

struct PopupViewPreview: PreviewProvider {
    static var previews: some View {
        PopupViewPreviewContainer()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
