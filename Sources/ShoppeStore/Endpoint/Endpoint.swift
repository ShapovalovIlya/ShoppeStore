//
//  Endpoint.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation
import Readers

@usableFromInline
typealias Endpoint = Reader<URLComponents, URLComponents>

extension Endpoint {
    @usableFromInline
    enum Scheme: String, Sendable { case http, https }
    
    @inlinable
    func scheme(_ s: Scheme) -> Self {
        reduce { $0.scheme = s.rawValue.capitalized }
    }
    
    @inlinable
    func withPath(_ p: String) -> Self {
        reduce { $0.path += "/".appending(p) }
    }
    
    @inlinable
    func url() -> Swift.Result<URL, Error> {
        Swift.Result {
            let components = apply(URLComponents())
            guard let url =  components.url else {
                throw URLError(.badURL, userInfo: ["components": components])
            }
            return url
        }
    }
    
    @usableFromInline
    static let fakestoreapi = Endpoint(\.self)
        .scheme(.https)
        .host("fakestoreapi.com")
    
    @usableFromInline
    static let products = Endpoint.fakestoreapi
        .withPath("products")
    
    @usableFromInline
    static let categories = Endpoint.products
        .withPath("categories")
        
    @inlinable
    static func product(withId id: Int) -> Self {
        Endpoint
            .products
            .withPath(id.description)
    }
    
    @inlinable
    static func product(in category: String) -> Self {
        Endpoint
            .products
            .withPath("category")
            .withPath(category)
    }
}
