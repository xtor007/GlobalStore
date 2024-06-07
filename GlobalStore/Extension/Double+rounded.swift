//
//  Double+rounded.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import Foundation

extension Double {
    func toTwoDecimalPlaces() -> String {
        return String(format: "%.2f", self)
    }
}
