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
    @State var payed: String = ""
    let numberformater: NumberFormatter
    
    init(isShowing: Binding<Bool>, viewModel: KirmesViewModel) {
        numberformater = NumberFormatter()
        numberformater.numberStyle = .currency
        numberformater.maximumFractionDigits = 2
        self._isShowing = isShowing
        self.viewModel = viewModel
    }
        
    var body: some View {
        GeometryReader {geometry in
            ZStack {
                Color.init(DrawingConstants.backgroundColor).ignoresSafeArea()
                
                CloseView(isShowing: $isShowing, payed: $payed)
                VStack {
                    Text("Test oke das sieht schon ganz gut aus")
                    TextField("0.00 €", value: $payed, formatter: numberformater)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .font(DrawingConstants.font(
                            size: geometry.size,
                            fontSize: DrawingConstants.textFieldFont))
                    Divider()
                    Text("Was steht hier? \(payed)")
                }.padding()
            }
        }
    }
}

struct CloseView: View {
    @Binding var isShowing: Bool
    @Binding var payed: String
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button( action: { test() } ) {
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
    private func test() {
        isShowing = false
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
    }
}
