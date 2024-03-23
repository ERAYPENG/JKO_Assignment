//
//  ProductItemTableViewCell.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/22.
//

import UIKit

class ProductItemTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var seperateLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.descriptionLabel.text = nil
        self.priceLabel.text = nil
    }
    
    func config(name: String, description: String, price: String) {
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        self.priceLabel.text = price
    }
}

// MARK: UI
extension ProductItemTableViewCell {
    private func setupUI() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.priceLabel)
        self.contentView.addSubview(self.seperateLine)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        self.descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.nameLabel.snp.trailing).offset(10)
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(200)
            make.height.equalTo(80)
        }
        self.priceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(self.nameLabel)
            make.height.equalTo(30)
        }
        self.seperateLine.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
