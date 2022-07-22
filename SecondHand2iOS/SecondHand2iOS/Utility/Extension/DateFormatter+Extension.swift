//
//  DateFormatter+Extension.swift
//  SecondHand2iOS
//
//  Created by Maulana Frasha on 21/07/22.
//

import UIKit

extension DateFormatter {
    static func convertFromISO(date: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMM, HH:mm"
        return dateFormatterPrint.string(from: dateFormatterGet.date(from: date)!)
    }
}
