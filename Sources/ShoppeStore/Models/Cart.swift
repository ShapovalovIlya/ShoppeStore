//
//  Cart.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 15.03.2025.
//

import Foundation

/*
 "id": 1,
    "userId": 1,
    "date": "2020-03-02T00:00:00.000Z",
    "products": [
      {
        "productId": 1,
        "quantity": 4
      },
      {
        "productId": 2,
        "quantity": 1
      },
      {
        "productId": 3,
        "quantity": 6
      }
    ],
 */

public struct Cart: Identifiable, Codable, Hashable, Sendable {
    public let id: Int
    public let userId: Int
    public let date: Date
    public let products: [Cart.Product]
    
    public init(id: Int, userId: Int, date: Date, products: [Cart.Product]) {
        self.id = id
        self.userId = userId
        self.date = date
        self.products = products
    }
}

public extension Cart {
    struct Product: Codable, Hashable, Sendable {
        public let productId: Int
        public let quantity: Int
        
        public init(productId: Int, quantity: Int) {
            self.productId = productId
            self.quantity = quantity
        }
    }
}
