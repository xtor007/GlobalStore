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
    
    @Published private(set) var isDataLoading = false
    
    init(dbManager: any DBManager) {
        self.dbManager = dbManager
        fetchDataFromDB()
    }
    
    func regenerateData() {
        isDataLoading = true
        Task {
            do {
                try await dbManager.regenerateDatabase(
                    productsCount: Constants.productsCount,
                    shopsCount: Constants.shopsCount
                )
                fetchDataFromDB()
                isDataLoading = false
            } catch {
                print(error)
                isDataLoading = false
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
