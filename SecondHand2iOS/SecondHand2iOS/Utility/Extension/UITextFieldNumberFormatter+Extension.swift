//
//  UITextFieldNumberFormatter+Extension.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 12/07/22.
//

import UIKit

class IntegerField: UITextField {
    var lastValue = 0
    let maxValue = 1_000_000_000
    var amount: Int {
        if let newValue = Int(string.digits), newValue < maxValue {
            lastValue = newValue
        } else if !hasText {
            lastValue = 0
        }
        return lastValue
    }
    override func didMoveToSuperview() {
        textAlignment = .left
        keyboardType = .numberPad
        text = Formatter.decimal.string(for: "")
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    @objc func editingChanged(_ textField: UITextField) {
        text = Formatter.decimal.string(for: amount)
    }
}

extension NumberFormatter {
    convenience init(numberStyle: Style) {
        self.init()
        self.numberStyle = numberStyle
    }
}

struct Formatter {
    static let decimal = NumberFormatter(numberStyle: .decimal)
}

extension UITextField {
    var string: String { return text ?? "" }
}

extension String {
    private static var digitsPattern = UnicodeScalar("0")..."9"
    var digits: String {
        return unicodeScalars.filter { String.digitsPattern ~= $0 }.string
    }
}

extension Sequence where Iterator.Element == UnicodeScalar {
    var string: String { return String(String.UnicodeScalarView(self)) }
}
