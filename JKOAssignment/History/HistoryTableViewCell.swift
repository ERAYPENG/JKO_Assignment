//
//  HistoryTableViewCell.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    private lazy var stackView: UIStackView = {
        let sView = UIStackView()
        sView.axis = .vertical
        return sView
    }()
    
    private lazy var totoalPriceLabel: UILabel = {
        let lbl = UILabel()
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
        self.dateLabel.text = nil
        self.stackView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func config(records: [TransactionRecord]) {
        guard let dateStr = records.first?.date else { return }
        self.dateLabel.text = dateStr
        var total = 0.0
        
        
        for record in records {
            total += record.totalPrice
            let subView = self.createStackViewSubView(record: record)
            self.stackView.addArrangedSubview(subView)
        }
        
        self.totoalPriceLabel.text = "總金額 : \(total)"
    }
}

// MARK: UI
private extension HistoryTableViewCell {
    func setupUI() {
        self.contentView.addSubview(self.stackView)
        self.contentView.addSubview(self.totoalPriceLabel)
        self.contentView.addSubview(self.dateLabel)
        self.contentView.addSubview(self.seperateLine)
        
        self.stackView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview().inset(16)
        }
        self.totoalPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.stackView.snp.bottom)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.totoalPriceLabel.snp.bottom)
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
    
    func createStackViewSubView(record: TransactionRecord) -> UIView {
        let view = UIView()
        let nameLabel = UILabel()
        let countLabel = UILabel()
        let totalPriceLabel = UILabel()
        totalPriceLabel.textAlignment = .right
        
        nameLabel.text = record.name
        countLabel.text = String(record.count)
        totalPriceLabel.text = String(record.totalPrice)
        
        view.addSubview(nameLabel)
        view.addSubview(countLabel)
        view.addSubview(totalPriceLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(16)
            make.width.equalTo(150)
        }
        countLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLabel.snp.trailing).offset(16)
            make.top.bottom.equalTo(nameLabel)
            make.width.equalTo(30)
        }
        totalPriceLabel.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview()
            make.top.bottom.equalTo(nameLabel)
            make.width.equalTo(100)
        }
        
        return view
    }
}
