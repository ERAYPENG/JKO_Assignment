//
//  HistoryTableViewCell.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var countLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .gray
        return lbl
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
        self.dateLabel.text = nil
    }
    
    func config(record: TransactionRecord) {
        self.nameLabel.text = record.name
        self.countLabel.text = record.count
        self.totalPriceLabel.text = record.totalPrice
        self.dateLabel.text = record.date
    }
}

private extension HistoryTableViewCell {
    func setupUI() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.countLabel)
        self.contentView.addSubview(self.totalPriceLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.seperateLine)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        self.countLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self.totalPriceLabel.snp.leading).offset(16)
            make.centerY.equalTo(self.nameLabel)
            make.width.equalTo(30)
            make.height.equalTo(self.nameLabel)
        }
        self.totalPriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(self.nameLabel)
            make.centerY.equalTo(self.nameLabel)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        self.seperateLine.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
