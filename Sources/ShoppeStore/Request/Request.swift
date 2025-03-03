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
    
    static let new = Request { URLRequest(url: $0) }
}
