//
//  ProductTableViewCell.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let cellId = "ProductTableViewCell"
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(resource: .foreground)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(resource: .foreground)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        setupName()
        setupPrice()
    }
    
    private func setupName() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizontalPadding)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupPrice() {
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Constants.horizontalPadding)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureCell(name: String, price: Double) {
        nameLabel.text = name
        priceLabel.text = price.toTwoDecimalPlaces()
    }
    
}

// MARK: Constants

fileprivate enum Constants {
    static let horizontalPadding: CGFloat = 16
}
