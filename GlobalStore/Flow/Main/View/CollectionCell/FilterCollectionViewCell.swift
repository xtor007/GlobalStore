//
//  FilterCollectionViewCell.swift
//  GlobalStore
//
//  Created by Anatoliy Khramchenko on 07.06.2024.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "FilterCollectionViewCell"
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Constants.cornerRadius
        view.layer.borderWidth = Constants.borderWidth
        view.layer.borderColor = UIColor(resource: .accent).cgColor
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeUI() {
        setupBorderView()
        setupName()
    }
    
    private func setupBorderView() {
        contentView.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupName() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configureCell(name: String, isSelected: Bool) {
        nameLabel.text = name
        nameLabel.textColor = UIColor(resource: isSelected ? .background : .foreground)
        borderView.backgroundColor = isSelected ? UIColor(resource: .accent) : .clear
    }
    
}

// MARK: - Constants

fileprivate enum Constants {
    static let cornerRadius: CGFloat = 8
    static let borderWidth: CGFloat = 2
}
