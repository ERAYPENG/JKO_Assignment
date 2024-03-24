//
//  CartViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class CartViewController: UIViewController {
    private var itemsDict: ItemsDict
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(CartTableViewCell.self, forCellReuseIdentifier: "CartTableViewCell")
        return t
    }()
    
    init(itemsDict: ItemsDict) {
        self.itemsDict = itemsDict
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
        
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemsDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
