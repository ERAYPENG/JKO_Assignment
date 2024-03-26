//
//  CheckoutViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/23.
//

import UIKit

class CheckoutViewController: UIViewController {
    private var items: [ProductItem] = []
    private var isCheckoutDirectly: Bool
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        t.separatorStyle = .none
        t.backgroundColor = .systemGroupedBackground
        t.delegate = self
        t.dataSource = self
        return t
    }()
    private lazy var totalPriceLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("提交訂單", for: .normal)
        btn.addTarget(self, action: #selector(confirmButtonDidTouchUpInside), for: .touchUpInside)
        return btn
    }()
    
    init(items: [ProductItem], isCheckoutDirectly: Bool = false) {
        self.items = items
        self.isCheckoutDirectly = isCheckoutDirectly
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.calculateTotalPrice()
    }
}

private extension CheckoutViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        self.title = "確認訂單"
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.totalPriceLabel)
        self.view.addSubview(self.confirmButton)
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        self.totalPriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(self.confirmButton)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.totalPriceLabel)
            make.width.equalTo(100)
        }
    }
    
    func calculateTotalPrice() {
        var totalPrice = 0.0
        for item in self.items {
            let count = Double(item.count ?? 0)
            let subTotal = count * item.price
            totalPrice += subTotal
        }
        self.totalPriceLabel.text = "總金額： \(totalPrice)"
    }
}

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        cell.isSelectable = false
        let data = self.items[indexPath.row]
        let totalPrice = Double(data.count ?? 0) * data.price
        cell.config(name: data.name, count: String(data.count ?? 0), totalPrice: String(totalPrice), isSelect: data.isSelect)
        return cell
    }
}

extension CheckoutViewController {
    @objc func confirmButtonDidTouchUpInside(sender: UIButton) {
        var records: [TransactionRecord] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = dateFormatter.string(from: Date())
        for item in self.items {
            let totalPrice = item.price * Double(item.count ?? 0)
            let newRecord = TransactionRecord(name: item.name, date: dateString, count: item.count ?? 0, totalPrice: totalPrice)
            records.append(newRecord)
        }
        TransactionHistory.shared.addRecords(records)
        if !self.isCheckoutDirectly {
            NotificationCenter.default.post(name: .itemsCleared, object: self.items)
        }
        self.showToast(message: "購買成功") {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
