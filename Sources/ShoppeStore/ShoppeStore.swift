// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import FoundationFX

public final class ShoppeStore: Sendable {
    public static let shared = ShoppeStore()
    
    public let persistence: Persistence
    
    let dataSession: URLSession
    let imageSession: URLSession
    let decoder: JSONDecoder
    
    //MARK: - init(_:)
    init() {
        self.persistence = Persistence()
        self.imageSession = URLSession(configuration: .imageSession)
        self.dataSession = URLSession(configuration: .dataSession)
        self.decoder = JSONDecoder()
    }
    
}

public extension ShoppeStore {
    //MARK: - Public methods
    func fetchImage(_ url: URL) async -> Result<Data, Error> {
        await imageSession.imageFrom(url)
    }
    
    func fetchAllProducts() async -> Result<[Product], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .products)
            .decodeJSON([Product].self, decoder: decoder)
    }
    
    func fetchAllCategories() async -> Result<[Product.Category], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .categories)
            .decodeJSON([Product.Category].self, decoder: decoder)
    }
    
    func fetchProduct(withId id: Int) async -> Result<Product, Error> {
        await dataSession
            .resultFrom(.get, endpoint: .product(withId: id))
            .decodeJSON(Product.self, decoder: decoder)
    }
    
    func fetchProducts(category: String) async -> Result<[Product], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .product(in: category))
            .decodeJSON([Product].self, decoder: decoder)
    }
    
    func deleteProduct(withId id: Int) async -> Result<Int, Error> {
        await dataSession
            .resultFrom(.delete, endpoint: .product(withId: id))
            .map { dump($0, name: "delete result"); return id }
    }
}
