//
//  Product.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation

/*
 {
     "id": 1,
     "title": "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
     "price": 109.95,
     "description": "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
     "category": "men's clothing",
     "image": "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
     "rating": {
       "rate": 3.9,
       "count": 120
     }
   },
 */

/*
 "electronics",
   "jewelery",
   "men's clothing",
   "women's clothing"
 */

public struct Product: Decodable, Hashable, Identifiable {
    public let id: Int
    public let title: String
    public let price: Double
    public let description: String
    public let category: Category
    public let image: URL
    public let rating: Rating
    
    public init(
        id: Int,
        title: String,
        price: Double,
        description: String,
        category: Category,
        image: URL,
        rating: Rating
    ) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }
}

public extension Product {
    enum Category: CaseIterable, Decodable {
        case electronics
        case jewelery
        case mensClothing
        case womensClothing
        
        enum CodingKeys: String, CodingKey {
            case electronics = "electronics"
            case jewelery = "jewelery"
            case mensClothing = "men's clothing"
            case womensClothing = "women's clothing"
        }
    }
    
    struct Rating: Decodable, Hashable {
        public let rate: Double
        public let count: Int
        
        public init(rate: Double, count: Int) {
            self.rate = rate
            self.count = count
        }
    }
}
