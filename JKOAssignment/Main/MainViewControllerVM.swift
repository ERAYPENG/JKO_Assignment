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
    var serialNumber: Int
}

class MainViewControllerVM {
    private(set) var items: [ProductItem] = []
    private(set) var cartItems: [ProductItem] = []
    
    let itemsPerPage: Int = 10
    let maxPage: Int = 3
    private(set) var isFetchingData: Bool = false
    
    init() {
        self.items = self.createMockData(startIndex: 0, isAscending: true)
    }
    
    func addItemToCart(item: ProductItem) {
        if let index = self.cartItems.firstIndex(where: { $0.name == item.name }) {
            var existingItem = self.cartItems[index]
            existingItem.count = (existingItem.count ?? 0) + 1
            self.cartItems[index] = existingItem
        } else {
            self.cartItems.insert(item, at: 0)
        }
    }
    func clearItems(items: [ProductItem]) {
        self.cartItems.removeAll { cartItem in
            items.contains(where: { $0.name == cartItem.name })
        }
    }
    func fetchMoreData(isAscending: Bool, completion: @escaping (Int) -> Void) {
        guard !self.isFetchingData else { return }
        self.isFetchingData = true
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self, let startItem = isAscending ? self.items.last : self.items.first else { return }
            let newItems = self.createMockData(startIndex: startItem.serialNumber, isAscending: isAscending)
            DispatchQueue.main.async {
                isAscending ? self.items.append(contentsOf: newItems) : self.items.insert(contentsOf: newItems, at: 0)
                let maxItems = self.itemsPerPage * self.maxPage
                if self.items.count > maxItems {
                    isAscending ? self.items.removeFirst(self.itemsPerPage) : self.items.removeLast(self.itemsPerPage)
                }
                self.isFetchingData = false
                completion(newItems.count)
            }
        }
    }
}

private extension MainViewControllerVM {
    func createMockData(startIndex: Int, isAscending: Bool) -> [ProductItem] {
        if self.items.first?.serialNumber == 1 && !isAscending {
            return []
        }
        let batchSize = 10
        var items: [ProductItem] = []
        
        let range: [Int]
        if isAscending {
            range = Array(startIndex + 1 ..< (startIndex + 1 + batchSize))
        } else {
            range = Array((max(startIndex - batchSize, 1) ..< startIndex).reversed())
        }
        for i in range {
            let name = "產品 #\(i)"
            let description = "這是產品 #\(i) 的描述。"
            let price = Double(i * 1000)
            let imageUrlStr = "https://picsum.photos/200/300"

            let item = ProductItem(name: name, description: description, price: price, imageUrlStr: imageUrlStr, serialNumber: i)
            isAscending ? items.append(item) : items.insert(item, at: 0)
        }

        return items
    }
}
