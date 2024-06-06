//
//  MainViewController.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import UIKit
import SnapKit

final class MainViewController<DatabaseType: DBManager>: UIViewController {
    private let dataStorage: MainViewControllerDataStorage<DatabaseType>
    
    // MARK: - Subviews
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.noData
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(resource: .grayForeground)
        return label
    }()
    
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
        makeUI()
    }
}

// MARK: - UI

extension MainViewController {
    private func makeUI() {
        setupBackground()
        setupNoDataLabel()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(resource: .background)
    }
    
    private func setupNoDataLabel() {
        view.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
