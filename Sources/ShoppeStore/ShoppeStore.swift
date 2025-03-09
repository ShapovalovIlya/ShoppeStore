// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import FoundationFX

/// Класс-фасад для работы с сервисами.
///
/// - Для работы с сетевым сервисом, экземпляр предоставляет набор асинхронных методов.
/// - Для работы с локальным хранилищем, используйте свойство `ShoppeStore.persistence`.
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
    
    /// Загрузить изображение по указанному `URL`.
    ///
    /// Для загрузки изображений используется отдельный экземпляр `URLSession`
    /// со своими настройками кэширования.
    /// - Returns: Результат запроса в виде `Data` или ошибка, возникшая в процессе.
    func fetchImage(_ url: URL) async -> Result<Data, Error> {
        await imageSession.imageFrom(url)
    }
    
    /// Загрузить весь список товаров.
    /// - Returns: Результат запроса в виде коллекции товаров или ошибка, возникшая в процессе
    func fetchAllProducts() async -> Result<[Product], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .products)
            .decodeJSON([Product].self, decoder: decoder)
    }
    
    /// Загрузить весь список категорий.
    /// - Returns: Результат запроса в виде коллекции категорий или ошибка, возникшая в процессе
    func fetchAllCategories() async -> Result<[Product.Category], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .categories)
            .decodeJSON([Product.Category].self, decoder: decoder)
    }
    
    /// Загрузить товар с указанным `id`.
    /// - Parameter id: Уникальный идентификатор товара.
    /// - Returns: Результат запроса в виде товара или ошибка, возникшая в процессе
    func fetchProduct(withId id: Int) async -> Result<Product, Error> {
        await dataSession
            .resultFrom(.get, endpoint: .product(withId: id))
            .decodeJSON(Product.self, decoder: decoder)
    }
    
    /// Загрузить товары указанной категории.
    /// - Parameter category: категория, согласно которой, нужно загрузить товары.
    /// - Returns: Результат запроса в виде коллекции товаров или ошибка, возникшая в процессе
    func fetchProducts(category: Product.Category) async -> Result<[Product], Error> {
        await dataSession
            .resultFrom(.get, endpoint: .product(in: category.rawValue))
            .decodeJSON([Product].self, decoder: decoder)
    }
    
    /// Удалить продукт с переданным `id`
    /// - Parameter id: Уникальный идентификатор товара
    /// - Returns: Результат запроса в виде идентификатора удаленного товара или ошибка, возникшая в процесса
    func deleteProduct(withId id: Int) async -> Result<Int, Error> {
        await dataSession
            .resultFrom(.delete, endpoint: .product(withId: id))
            .map { _ in id }
    }
}
