//
//  Request.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation
import Readers

@usableFromInline
typealias Request = Reader<URL, URLRequest>

extension Request {
    @usableFromInline
    enum Method: String, Sendable { case get, post, put, delete }
    
    @inlinable func method(_ m: Method) -> Self {
        reduce { $0.httpMethod = m.rawValue.uppercased() }
    }
    
    @inlinable func withBody(_ b: Data) -> Self {
        reduce { $0.httpBody = b }
    }
    
    @inlinable func withHeader(_ key: String, value: String) -> Self {
        reduce { $0.addValue(value, forHTTPHeaderField: key) }
    }
    
    @usableFromInline static let new = Request { URLRequest(url: $0) }
    @usableFromInline static let get = Request.new.method(.get)
    @usableFromInline static let delete = Request.new.method(.delete)
    
    @inlinable
    static func post(_ b: Data) -> Self {
        Request.new
            .method(.post)
            .withHeader("Content-Type", value: "application/json'")
            .withBody(b)
    }
}
