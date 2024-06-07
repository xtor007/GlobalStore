//
//  MainViewControllerStorage.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

class MainViewControllerDataStorage: ObservableObject {
    
    private let dbManager: any DBManager
    
    @Published private(set) var shops = [any Shop]()
    private var products = [Product]()
    
    @Published private(set) var productsToShow = [Product]()
    
    init(dbManager: any DBManager) {
        self.dbManager = dbManager
        fetchDataFromDB()
    }
    
    func regenerateData() {
        Task {
            do {
                try await dbManager.regenerateDatabase(
                    productsCount: Constants.productsCount,
                    shopsCount: Constants.shopsCount
                )
                fetchDataFromDB()
            } catch {
                print(error)
            }
        }
    }
    
}

// MARK: - Update data

extension MainViewControllerDataStorage {
    private func fetchDataFromDB() {
        Task {
            do {
                shops = try await dbManager.getShops()
                products = try await dbManager.getProducts()
                updateProducts()
            } catch {
                print(error)
            }
        }
    }
    
    private func updateProducts() {
        productsToShow = products
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let productsCount = 100000
    static let shopsCount = 10
}
