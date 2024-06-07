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
    
    static var regenerate: String {
        text(for: "regenerate")
    }
    
    static var all: String {
        text(for: "all")
    }
    
    private static func text(for key: String) -> String {
        NSLocalizedString(key, comment: "")
    }
}
