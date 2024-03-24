//
//  MainViewControllerVM.swift
//  JKOAssignment
//
//  Created by ERAY on 2024/3/22.
//

import Foundation

struct ProductItem: Hashable {
    let name: String
    let description: String
    let price: Double
    let imageUrlStr: String
    var count: Int?
    var isSelect: Bool = false
}

class MainViewControllerVM {
    var items: [ProductItem] = []
    var cartItems: [ProductItem] = []
    
    init() {
        self.items = self.createMockData()
    }
    
    func addItemToCart(item: ProductItem) {
        if let index = self.cartItems.firstIndex(where: { $0.name == item.name }) {
            var existingItem = self.cartItems[index]
            existingItem.count = (existingItem.count ?? 0) + 1
            self.cartItems[index] = existingItem
        } else {
            var newItem = item
            newItem.count = 1
            self.cartItems.insert(newItem, at: 0)
        }
    }
    func clearItems(items: [ProductItem]) {
        self.cartItems.removeAll { cartItem in
            items.contains(where: { $0.name == cartItem.name })
        }
    }
}

private extension MainViewControllerVM {
    func createMockData() -> [ProductItem] {
        return [
            ProductItem(name: "iPhone 13", description: "全新的 A15 仿生晶片，速度更快", price: 799.0, imageUrlStr: "https://picsum.photos/200/300?grayscale"),
            ProductItem(name: "MacBook Pro", description: "配備 M1 Pro 或 M1 Max 芯片，性能極致強大", price: 1999.0, imageUrlStr: "https://picsum.photos/200/300?grayscale"),
            ProductItem(name: "AirPods Pro", description: "全新的輕鬆聽感，降噪效果更佳", price: 249.0, imageUrlStr: "https://picsum.photos/200/300?grayscale")
        ]
    }
}
