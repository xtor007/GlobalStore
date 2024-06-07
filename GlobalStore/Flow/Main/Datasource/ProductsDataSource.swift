//
//  ProductsDataSource.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import UIKit

class ProductsDataSource: NSObject, UITableViewDataSource {
    private let storage: MainViewControllerDataStorage
    
    init(storage: MainViewControllerDataStorage) {
        self.storage = storage
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        storage.productsToShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.cellId, for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = storage.productsToShow[indexPath.row]
        cell.configureCell(name: product.title, price: product.price)
        return cell
    }
}
