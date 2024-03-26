//
//  HistoryViewController.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import UIKit

class HistoryViewController: UIViewController {
    
    private lazy var alertLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "無歷史紀錄"
        lbl.backgroundColor = .clear
        return lbl
    }()
    private lazy var tableView: UITableView = {
        let t = UITableView()
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        t.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
        return t
    }()

    init() {
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
private extension HistoryViewController {
    func setupUI() {
        self.view.backgroundColor = .systemGroupedBackground
        
        let button = UIButton()
        button.setTitle("清除", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(rightBarButtonDidTouchUpInside), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.view.addSubview(self.alertLabel)
        self.view.addSubview(self.tableView)
        
        self.alertLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        self.tableView.isHidden = TransactionHistory.shared.records.count == 0
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TransactionHistory.shared.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        let data = TransactionHistory.shared.records[indexPath.row]
        cell.config(record: data)
        return cell
    }
}

private extension HistoryViewController {
    @objc func rightBarButtonDidTouchUpInside() {
        TransactionHistory.shared.deleteAllRecords()
        self.tableView.isHidden = true
    }
}
