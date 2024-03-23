//
//  MainViewControllerVM.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/22.
//

import Foundation

struct ProductItem {
    let name: String
    let description: String
    let price: Double
}

class MainViewControllerVM {
    var items: [ProductItem] = []
    init() {
        self.items = self.createMockData()
    }
    func createMockData() -> [ProductItem] {
        return [
            ProductItem(name: "iPhone 13", description: "全新的 A15 仿生晶片，速度更快", price: 799.0),
            ProductItem(name: "MacBook Pro", description: "配備 M1 Pro 或 M1 Max 芯片，性能極致強大", price: 1999.0),
            ProductItem(name: "AirPods Pro", description: "全新的輕鬆聽感，降噪效果更佳", price: 249.0)
        ]
    }
}
