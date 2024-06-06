//
//  Shop.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

protocol Shop {
    associatedtype ProductType: Product
    
    var id: UUID { get }
    var name: String { get }
    var products: [ProductType] { get }
}
