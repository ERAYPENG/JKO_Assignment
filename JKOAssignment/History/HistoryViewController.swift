//
//  HistoryViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class HistoryViewController: UIViewController {
    private var items: [TransactionRecord] = []
    
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
        return t
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

// MARK: UI
private extension HistoryViewController {
    func setupUI() {
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
