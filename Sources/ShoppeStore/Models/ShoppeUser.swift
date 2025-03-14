//
//  ShoppeUser.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 14.03.2025.
//

import Foundation

public struct ShoppeUser: Codable, Sendable {
    public let id: Int
    public let username: String
    public let email: String
    public let password: String
    
    public init(
        id: Int,
        username: String,
        email: String,
        password: String
    ) {
        self.id = id
        self.username = username
        self.email = email
        self.password = password
    }
}
