//
//  TransactionHistory.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/24.
//

import Foundation

struct TransactionRecord {
    var name: String
    var date: Date
    var amount: Double
    var price: Double
}

class TransactionHistory {
    static let shared = TransactionHistory()

    private init() {}

    var records: [TransactionRecord] = []

    func addRecord(_ record: TransactionRecord) {
        records.append(record)
    }

    func deleteAllRecords() {
        records.removeAll()
    }
}
