//
//  MainViewController.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import UIKit

final class MainViewController<DatabaseType: DBManager>: UIViewController {
    
    private let dataStorage: MainViewControllerDataStorage<DatabaseType>
    
    // MARK: - Life
    
    init(dataStorage: MainViewControllerDataStorage<DatabaseType>) {
        self.dataStorage = dataStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

}
