//
//  CheckoutViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/23.
//

import UIKit

typealias ItemsDict = [ProductItem: Int]

class CheckoutViewController: UIViewController {
    private var itemsDict: ItemsDict
    private var items: [ProductItem] = []
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.register(CheckoutTableViewCell.self, forCellReuseIdentifier: "CheckoutTableViewCell")
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    private lazy var confirmButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("確認訂單", for: .normal)
        return btn
    }()
    
    init(itemsDict: ItemsDict) {
        self.itemsDict = itemsDict
        self.items = Array(itemsDict.keys)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

private extension CheckoutViewController {
    func setupUI() {
        self.title = "確認訂單"
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.confirmButton)
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutTableViewCell", for: indexPath) as? CheckoutTableViewCell else {
            return UITableViewCell()
        }
        let data = self.items[indexPath.row]
        if let count = self.itemsDict[data] {
            
        }
        return cell
    }
}
