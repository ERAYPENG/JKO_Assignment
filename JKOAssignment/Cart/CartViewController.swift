//
//  CartViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class CartViewController: UIViewController {
    weak var delegate: CartActionDelegate?
    private var items: [ProductItem]
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        return t
    }()
    private lazy var checkoutButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .red
        btn.setTitle("前往結賬", for: .normal)
        btn.addTarget(self, action: #selector(checkoutButtonDidTouchUpInside), for: .touchUpInside)
        return btn
    }()
    private lazy var alertLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "您的購物車是空的"
        lbl.backgroundColor = .clear
        return lbl
    }()
    
    init(items: [ProductItem]) {
        self.items = items
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

// MARK: UI
private extension CartViewController {
    func setupUI() {
        self.view.backgroundColor = .systemGroupedBackground
        
        self.view.addSubview(self.alertLabel)
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.checkoutButton)
        
        self.alertLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-60)
        })
        self.checkoutButton.snp.makeConstraints({ (make) in
            make.top.equalTo(self.tableView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        })
        
        self.tableView.isHidden = self.items.count == 0
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
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
        let data = self.items[indexPath.row]
        let totalPrice = Double(data.count ?? 0) * data.price
        
        cell.config(name: data.name, count: String(data.count ?? 0), totalPrice: String(totalPrice), isSelect: data.isSelect)
        cell.onToggleSelect = { [weak self] isSelect in
            guard let self = self else { return }
            self.items[indexPath.row].isSelect = isSelect
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.items[indexPath.row].isSelect.toggle()
        self.tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }
            self.delegate?.didDeleteFromCart(item: self.items[indexPath.row])
            self.items.remove(at: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

// MARK: Action
private extension CartViewController {
    @objc func checkoutButtonDidTouchUpInside(sender: UIButton) {
        let selectItems = self.items.filter({ $0.isSelect })
        guard selectItems.count > 0 else {
            self.showToast(message: "請先將商品加入購物車")
            return
        }
        let vc = CheckoutViewController(items: selectItems)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
