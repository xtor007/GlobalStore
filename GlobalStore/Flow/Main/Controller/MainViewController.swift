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
    private let filterDataSource: FilterDataSource
    
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var filterCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Cancelable
    
    private var shopsCancellable: AnyCancellable?
    private var productsCancellable: AnyCancellable?
    private var loadingCancellable: AnyCancellable?
    
    // MARK: - Life
    
    init(dataStorage: MainViewControllerDataStorage) {
        self.dataStorage = dataStorage
        filterDataSource = FilterDataSource(storage: dataStorage)
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
        shopsCancellable = dataStorage.$shops.sink { [weak self] shops in
            guard let self else { return }
            changeCategoriesVisibilityIfNeeded(shops.isEmpty)
        }
        productsCancellable = dataStorage.$productsToShow.sink { [weak self] products in
            guard let self else { return }
            changeTableVisibilityIfNeeded(products.isEmpty)
        }
        loadingCancellable = dataStorage.$isDataLoading.sink(receiveValue: { [weak self] isLoading in
            guard let self else { return }
            changeActivtyIndicatorVisibility(isLoading)
        })
    }
}

// MARK: - UI

extension MainViewController {
    private func makeUI() {
        setupBackground()
        setupRegenerateButton()
        setupNoDataLabel()
        setupActivityIndicator()
        setupFilters()
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
    
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupFilters() {
        view.addSubview(filterCollection)
        filterCollection.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizontalPadding)
            make.trailing.equalToSuperview().offset(-Constants.horizontalPadding)
            make.top.equalTo(regenerateButton.snp.bottom).offset(Constants.verticalSpacing)
            make.height.equalTo(Constants.collectionCellHeight)
        }
        filterCollection.dataSource = filterDataSource
        filterCollection.delegate = self
        filterCollection.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.cellId)
    }
    
    private func updateUI() {
        changeCategoriesVisibilityIfNeeded(dataStorage.shops.isEmpty)
        changeTableVisibilityIfNeeded(dataStorage.productsToShow.isEmpty)
    }
    
    private func changeActivtyIndicatorVisibility(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            activityIndicator.isHidden = !isLoading
            regenerateButton.isEnabled = !isLoading
            if isLoading {
                noDataLabel.isHidden = true
            } else {
                noDataLabel.isHidden = !dataStorage.productsToShow.isEmpty
            }
        }
    }
    
    private func changeCategoriesVisibilityIfNeeded(_ isEmpty: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            filterCollection.isHidden = isEmpty
            if !isEmpty {
                filterCollection.reloadData()
            }
        }
    }
    
    private func changeTableVisibilityIfNeeded(_ isEmpty: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            noDataLabel.isHidden = !isEmpty
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

// MARK: - Collection

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.collectionCellWidth, height: Constants.collectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            dataStorage.filter = .all
        } else {
            dataStorage.filter = .shop(indexPath.row - 1)
        }
        filterCollection.reloadData()
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let buttonTopPadding: CGFloat = 20
    static let buttonTrailingPadding: CGFloat = 16
    static let buttonWidth: CGFloat = 100
    static let buttonHeight: CGFloat = 20
    
    static let verticalSpacing: CGFloat = 16
    static let horizontalPadding: CGFloat = 16
    
    static let collectionCellHeight: CGFloat = 30
    static let collectionCellWidth: CGFloat = 100
}
