//
//  String+generate.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import Foundation

extension String {
    static func generate(_ range: Range<Int>) -> String {
        let length = range.randomElement() ?? 0
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var result = ""
        for _ in 0..<length {
            if let randomCharacter = characters.randomElement() {
                result.append(randomCharacter)
            }
        }
        return result
    }
}
