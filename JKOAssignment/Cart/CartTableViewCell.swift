//
//  CartTableViewCell.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    var onToggleSelect: ((Bool) -> Void)?
    
    var isSelectable: Bool = true {
        didSet {
            self.selectButton.isHidden = !isSelectable
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var countLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private lazy var selectButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "checkmark_circle_deselect"), for: .normal)
        btn.setImage(UIImage(named: "checkmark_circle_select"), for: .selected)
        btn.addTarget(self, action: #selector(toggleSelect), for: .touchUpInside)
        return btn
    }()
    
    private lazy var seperateLine: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.countLabel.text = nil
        self.totalPriceLabel.text = nil
    }
    
    func config(name: String, count: String, totalPrice: String, isSelect: Bool) {
        self.nameLabel.text = name
        self.countLabel.text = count
        self.totalPriceLabel.text = totalPrice
        self.selectButton.isSelected = isSelect
    }
}

// MARK: UI
private extension CartTableViewCell {
    func setupUI() {
        self.contentView.addSubview(self.selectButton)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.countLabel)
        self.contentView.addSubview(self.totalPriceLabel)
        self.contentView.addSubview(self.seperateLine)
        
        self.selectButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        self.nameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.selectButton.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(48)
        }
        self.countLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.nameLabel.snp.trailing).offset(16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(self.nameLabel)
        }
        self.totalPriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(self.nameLabel)
        }
        self.seperateLine.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}

// MARK: Action
extension CartTableViewCell {
    @objc func toggleSelect() {
        self.selectButton.isSelected = !self.selectButton.isSelected
        self.onToggleSelect?(self.selectButton.isSelected)
    }
}
