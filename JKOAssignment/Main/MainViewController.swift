//
//  MainViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/22.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let viewModel: MainViewControllerVM = MainViewControllerVM()
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.backgroundColor = .systemGroupedBackground
        t.register(ProductItemTableViewCell.self, forCellReuseIdentifier: "ProductItemTableViewCell")
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        return t
    }()
    private lazy var countLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .white
        return lbl
    }()
    private lazy var cartButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

// MARK: UI
private extension MainViewController {
    func setupUI() {
        self.title = "KKKK"
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.countLabel)
        self.view.addSubview(self.cartButton)
        
        self.tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        })
        self.countLabel.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(self.tableView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.equalTo(self.cartButton.snp.leading)
        })
        self.cartButton.snp.makeConstraints({ (make) in
            make.top.equalTo(self.countLabel)
            make.bottom.equalTo(self.countLabel)
            make.trailing.equalToSuperview()
            make.width.equalTo(60)
        })
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemTableViewCell", for: indexPath) as? ProductItemTableViewCell else {
            return UITableViewCell()
        }
        let data = self.viewModel.items[indexPath.row]
        cell.config(name:data.name, description:data.description, price:String(data.price))
        return cell
    }
}
