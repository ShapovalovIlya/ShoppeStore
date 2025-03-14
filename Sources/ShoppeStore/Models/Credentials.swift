//
//  Credentials.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 10.03.2025.
//

import Foundation

public struct Credentials: Hashable, Encodable, Sendable {
    public let username: String
    public let password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
