//
//  RealmManager.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import Foundation
import RealmSwift

class RealmManager: DBManager {
    
    static let shared = RealmManager()
    
    private let realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getShops() async throws -> [ShopObject] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                continuation.resume(returning: Array(realm.objects(ShopObject.self)))
            }
        }
    }
    
    func getProducts() async throws -> [ProductObject] {
        return await withCheckedContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                continuation.resume(returning: Array(realm.objects(ProductObject.self)))
            }
        }
    }
    
    func regenerateDatabase(productsCount: Int, shopsCount: Int) async throws {
        try await clearDB()
        let products = regenerateProducts(productsCount)
        let shops = regenerateShops(shopsCount)
        for product in products {
            guard let randomShop = shops.randomElement() else {
                return
            }
            randomShop.productsList.append(product)
        }
        try await asyncDBAction { [weak self] in
            guard let self else { return }
            realm.add(products)
            realm.add(shops)
        }
    }
    
    private func asyncDBAction(_ action: @escaping (() -> Void)) async throws {
        let _: Bool = try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                do {
                    try realm.write {
                       action()
                    }
                    continuation.resume(returning: true)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    private func clearDB() async throws {
        try await asyncDBAction { [weak self] in
            guard let self else { return }
            realm.deleteAll()
        }
    }
    
    private func regenerateProducts(_ count: Int) -> [ProductObject] {
        var products = [ProductObject]()
        for _ in 0..<count {
            let product = ProductObject()
            product.title = String.generate(5..<10)
            product.price = Double.random(in: 1.0...100.0)
            products.append(product)
        }
        return products
    }
    
    private func regenerateShops(_ count: Int) -> [ShopObject] {
        var shops = [ShopObject]()
        for _ in 0..<count {
            let shop = ShopObject()
            shop.name = String.generate(5..<10)
            shops.append(shop)
        }
        return shops
    }
    
}
