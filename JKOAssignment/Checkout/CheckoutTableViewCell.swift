//
//  CheckoutTableViewCell.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/23.
//

import UIKit

class CheckoutTableViewCell: UITableViewCell {

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
    }
}

private extension CheckoutTableViewCell {
    func setupUI() {
        self.contentView.addSubview(self.seperateLine)
        
        self.seperateLine.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
