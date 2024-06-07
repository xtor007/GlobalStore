//
//  ProductObject.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import Foundation
import RealmSwift

class ProductObject: Object, Product {
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var price: Double = 0.0
    
    let shop = LinkingObjects(fromType: ShopObject.self, property: "productsList")
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
