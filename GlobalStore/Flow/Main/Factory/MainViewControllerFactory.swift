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
    func getShops() async throws -> [SimpleShop] {
        return []
    }
    
    func getProducts() async throws -> [SimpleProduct] {
        return []
    }
    
    func regenerateDatabase(productsCount: Int) async throws {
        ()
    }
}
