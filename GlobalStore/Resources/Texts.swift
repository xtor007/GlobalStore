//
//  Texts.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

final class Texts {
    static var noData: String {
        text(for: "noData")
    }
    
    private static func text(for key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}
