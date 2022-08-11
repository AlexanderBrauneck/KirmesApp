//
//  CurrencyTextField.swift
//  Kirmes App
//

import Foundation
import UIKit
import SwiftUI

class CurrencyUITextField: UITextField {
    
    @Binding private var value: Int
    private let formatter: NumberFormatter
    
    init(formatter: NumberFormatter, value: Binding<Int>, placeholder: String) {
        self.formatter = formatter
        self._value = value
        super.init(frame: .zero)
        setupViews()
        self.placeholder = placeholder
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        addTarget(self, action: #selector(resetSelection), for: .allTouchEvents)
        keyboardType = .numberPad
        textAlignment = .right
        sendActions(for: .editingChanged)
    }
    override func deleteBackward() {
        text = textValue.digits.dropLast().string
        sendActions(for: .editingChanged)
    }
    private func setupViews() {
        tintColor = .clear
        font = .systemFont(ofSize: 40, weight: .regular)
    }
    @objc private func editingChanged() {
        if self.isEditing {
            text = currency(from: decimal)
            resetSelection()
            value = Int(doubleValue * 100)
        }
    }
    @objc private func resetSelection() {
        selectedTextRange = textRange(from: endOfDocument, to: endOfDocument)
    }
    private var textValue: String {
        return text ?? ""
    }
    private var doubleValue: Double {
        return (decimal as NSDecimalNumber).doubleValue
    }
    private var decimal: Decimal {
        return textValue.decimal / pow(10, formatter.maximumFractionDigits)
    }
    private func currency(from decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }
}


extension StringProtocol where Self: RangeReplaceableCollection {
    var digits: Self { filter (\.isWholeNumber) }
}


extension String {
    var decimal: Decimal { Decimal(string: digits) ?? 0 }
}


extension LosslessStringConvertible {
    var string: String { .init(self) }
}


struct CurrencyTextField: UIViewRepresentable {

    let numberFormatter: NumberFormatter
    let currencyField: CurrencyUITextField
    
    init(numberFormatter: NumberFormatter, value: Binding<Int>, placeholder: String) {
        self.numberFormatter = numberFormatter
        currencyField = CurrencyUITextField(formatter: numberFormatter, value: value, placeholder: placeholder)
    }
    
    func makeUIView(context: Context) -> CurrencyUITextField {
        return currencyField
    }
    
    func updateUIView(_ uiView: CurrencyUITextField, context: Context) { }
}
