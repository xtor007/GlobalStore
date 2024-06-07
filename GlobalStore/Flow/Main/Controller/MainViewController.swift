//
//  MainViewController.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 06.06.2024.
//

import UIKit
import SnapKit
import Combine

final class MainViewController: UIViewController {
    private let dataStorage: MainViewControllerDataStorage
    
    // MARK: - Subviews
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.noData
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(resource: .grayForeground)
        return label
    }()
    
    private lazy var regenerateButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(resource: .button), for: .normal)
        button.setTitleColor(UIColor(resource: .button).withAlphaComponent(0.3), for: .highlighted)
        button.setTitle(Texts.regenerate, for: .normal)
        button.addTarget(self, action: #selector(regenerateAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Cancelable
    
    private var shopsCancellable: AnyCancellable?
    private var productsCancellable: AnyCancellable?
    
    // MARK: - Life
    
    init(dataStorage: MainViewControllerDataStorage) {
        self.dataStorage = dataStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        subscribeForChangingStorage()
    }
    
    private func subscribeForChangingStorage() {
        shopsCancellable = dataStorage.$shops.sink { [weak self] _ in
            guard let self else { return }
            changeCategoriesVisibilityIfNeeded()
        }
        productsCancellable = dataStorage.$productsToShow.sink { [weak self] _ in
            guard let self else { return }
            changeTableVisibilityIfNeeded()
        }
    }
}

// MARK: - UI

extension MainViewController {
    private func makeUI() {
        setupBackground()
        setupRegenerateButton()
        setupNoDataLabel()
        updateUI()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(resource: .background)
    }
    
    private func setupRegenerateButton() {
        view.addSubview(regenerateButton)
        regenerateButton.snp.makeConstraints { make in
            make.width.equalTo(Constants.buttonWidth)
            make.height.equalTo(Constants.buttonHeight)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.buttonTopPadding)
            make.trailing.equalToSuperview().offset(-Constants.buttonTrailingPadding)
        }
    }
    
    private func setupNoDataLabel() {
        view.addSubview(noDataLabel)
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func updateUI() {
        changeCategoriesVisibilityIfNeeded()
        changeTableVisibilityIfNeeded()
    }
    
    private func changeCategoriesVisibilityIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if dataStorage.shops.isEmpty {
                
            } else {
                
            }
        }
    }
    
    private func changeTableVisibilityIfNeeded() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if dataStorage.productsToShow.isEmpty {
                noDataLabel.isHidden = false
            } else {
                noDataLabel.isHidden = true
            }
        }
    }
}

// MARK: - Actions

extension MainViewController {
    @objc
    private func regenerateAction(_ sender: UIButton) {
        dataStorage.regenerateData()
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let buttonTopPadding: CGFloat = 20
    static let buttonTrailingPadding: CGFloat = 16
    static let buttonWidth: CGFloat = 100
    static let buttonHeight: CGFloat = 20
}
