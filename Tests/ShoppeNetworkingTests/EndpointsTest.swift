//
//  Test.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Testing
import Foundation
@testable import ShoppeStore

struct EndpointsTest {

    @Test func allProducts() async throws {
        let sut = try Endpoint.products.url().get()
        #expect(sut.absoluteString == "Https://fakestoreapi.com/products")
    }

    @Test func productWithId() async throws {
        let sut = try Endpoint.product(withId: 1).url().get()
        #expect(sut.absoluteString == "Https://fakestoreapi.com/products/1")
    }
    
    @Test func categories() async throws {
        let sut = try Endpoint.categories.url().get()
        #expect(sut.absoluteString == "Https://fakestoreapi.com/products/categories")
    }
    
    @Test func category() async throws {
        let sut = try Endpoint.product(in: "baz").url().get()
        #expect(sut.absoluteString == "Https://fakestoreapi.com/products/category/baz")
    }
}
