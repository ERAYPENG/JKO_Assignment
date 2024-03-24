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
    private lazy var cartButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setImage(UIImage(named: "cart"), for: .normal)
        btn.addTarget(self, action: #selector(cartButtonDidTouchUpInside), for: .touchUpInside)
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
        let button = UIButton()
        button.setImage(UIImage(named: "history"), for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonDidTouchUpInside), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightButton
        self.title = "商品列表"
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.cartButton)
        
        self.tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        })
        self.cartButton.snp.makeConstraints({ (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(item:self.viewModel.items[indexPath.row])
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: AddToCartDelegate {
    func didAddToCart(item: ProductItem) {
        
    }
}

extension MainViewController {
    @objc func cartButtonDidTouchUpInside(sender: UIButton) {
        let vc = CartViewController(itemsDict: self.viewModel.itemsDict)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func rightBarButtonDidTouchUpInside(sender: UIButton) {
        let vc = HistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
