//
//  DBManager.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

protocol DBManager: AnyObject {
    associatedtype ShopType: Shop
    
    func getShops() async throws -> [ShopType]
    func getProducts() async throws -> [ShopType.ProductType]
    func regenerateDatabase(productsCount: Int, shopsCount: Int) async throws
}
