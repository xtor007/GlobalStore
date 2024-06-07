//
//  FilterDataSource.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import UIKit

class FilterDataSource: NSObject, UICollectionViewDataSource {
    private let storage: MainViewControllerDataStorage
    
    init(storage: MainViewControllerDataStorage) {
        self.storage = storage
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        storage.shops.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.cellId, for: indexPath) as? FilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        if indexPath.row == 0 {
            cell.configureCell(name: Texts.all, isSelected: storage.filter == .all)
        } else {
            let shopIndex = indexPath.row - 1
            cell.configureCell(name: storage.shops[shopIndex].name, isSelected: storage.filter == .shop(shopIndex))
        }
        return cell
    }
}
