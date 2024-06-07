//
//  MainViewControllerFactory.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import UIKit

final class MainViewControllerFactory {
    func makeMainViewController() -> UIViewController {
        let storage = MainViewControllerDataStorage(dbManager: SimpleDB())
        let mainVC = MainViewController(dataStorage: storage)
        return mainVC
    }
}

struct SimpleProduct: Product {
    var id: UUID
    var title: String
    var price: Double
}

struct SimpleShop: Shop {
    var id: UUID
    var name: String
    var products: [SimpleProduct]
}

class SimpleDB: DBManager {
    private var shops = [SimpleShop]()
    private var products = [SimpleProduct]()
    
    func getShops() async throws -> [SimpleShop] {
        shops
    }
    
    func getProducts() async throws -> [SimpleProduct] {
        products
    }
    
    func regenerateDatabase(productsCount: Int, shopsCount: Int) async throws {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        products = [
            SimpleProduct(id: UUID(), title: "1", price: 1.0),
            SimpleProduct(id: UUID(), title: "2", price: 2.0),
            SimpleProduct(id: UUID(), title: "3", price: 3.0),
            SimpleProduct(id: UUID(), title: "4", price: 4.0),
            SimpleProduct(id: UUID(), title: "5", price: 5.0),
            SimpleProduct(id: UUID(), title: "6", price: 6.0),
            SimpleProduct(id: UUID(), title: "7", price: 7.0),
            SimpleProduct(id: UUID(), title: "8", price: 8.0),
            SimpleProduct(id: UUID(), title: "9", price: 9.0),
            SimpleProduct(id: UUID(), title: "10", price: 10.0)
        ]
        shops = [
            SimpleShop(id: UUID(), name: "first", products: Array(products[0...4])),
            SimpleShop(id: UUID(), name: "second", products: Array(products[5...9]))
        ]
    }
}
