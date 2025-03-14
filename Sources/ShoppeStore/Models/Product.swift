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

public struct Product: Decodable, Hashable, Identifiable, Sendable {
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
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case price
        case description
        case category
        case image
        case rating
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Double.self, forKey: .price)
        self.description = try container.decode(String.self, forKey: .description)
        let categoryString = try container.decode(String.self, forKey: .category)
        guard let category = Category(rawValue: categoryString) else {
            throw DecodingError.typeMismatch(
                Category.self,
                DecodingError.Context(
                    codingPath: [CodingKeys.category],
                    debugDescription: "Invalid value"
                )
            )
        }
        self.category = category
        self.image = try container.decode(URL.self, forKey: .image)
        self.rating = try container.decode(Product.Rating.self, forKey: .rating)
    }
}

public extension Product {
    enum Category: String, CaseIterable, Decodable, Sendable {
        case electronics
        case jewelery
        case mensClothing = "men's clothing"
        case womensClothing = "women's clothing"
    }
    
    struct Rating: Decodable, Hashable, Sendable {
        public let rate: Double
        public let count: Int
        
        public init(rate: Double, count: Int) {
            self.rate = rate
            self.count = count
        }
    }
}
