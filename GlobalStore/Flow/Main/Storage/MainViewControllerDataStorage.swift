//
//  MainViewControllerStorage.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

class MainViewControllerDataStorage<DatabaseType: DBManager> {
    
    private let dbManager: DatabaseType
    
    private var shops = [DatabaseType.ShopType]()
    private var products = [DatabaseType.ShopType.ProductType]()
    
    init(dbManager: DatabaseType) {
        self.dbManager = dbManager
        fetchDataFromDB()
    }
    
}

// MARK: - Update data

extension MainViewControllerDataStorage {
    private func fetchDataFromDB() {
        Task {
            do {
                shops = try await dbManager.getShops()
                products = try await dbManager.getProducts()
                refreshUI()
            } catch {
                print(error)
            }
        }
    }
    
    private func refreshUI() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
        }
    }
}
