//
//  MainViewControllerStorage.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import Foundation

class MainViewControllerDataStorage {
    
    private let dbManager: any DBManager
    
    private var shops = [any Shop]()
    private var products = [Product]()
    
    init(dbManager: any DBManager) {
        self.dbManager = dbManager
        fetchDataFromDB()
    }
    
    func regenerateData() {
        print("1")
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
