//
//  ShopObject.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import Foundation
import RealmSwift

class ShopObject: Object, Shop {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var name: String = ""
    let productsList = List<ProductObject>()
    
    var products: [ProductObject] {
        Array(productsList)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
