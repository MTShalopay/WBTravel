//
//  String+Extension.swift
//  WBTravel
//
//  Created by Shalopay on 13.05.2023.
//

import Foundation
public extension String {
    func convertDateFormat() -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let oldDate = olDateFormatter.date(from: self) ?? Date()
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.locale = Locale(identifier: "ru_RU")
        convertDateFormatter.dateFormat = "E dd MMMM, HH:mm"
        return convertDateFormatter.string(from: oldDate)
   }
}
