//
//  TransactionHistory.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import Foundation

struct TransactionRecord {
    var name: String
    var date: String
    var count: Int
    var totalPrice: Double
}

class TransactionHistory {
    static let shared = TransactionHistory()

    private init() {}

    var records: [[TransactionRecord]] = []

    func addRecords(_ records: [TransactionRecord]) {
        self.records.insert(records, at: 0)
    }

    func deleteAllRecords() {
        self.records.removeAll()
    }
}
