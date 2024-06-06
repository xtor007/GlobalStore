//
//  Product.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

protocol Product {
    var id: UUID { get }
    var title: String { get }
    var price: Double { get }
}
