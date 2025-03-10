//
//  Persistence.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 09.03.2025.
//

import Foundation
import SwiftFP

public final class Persistence: Sendable {
    private let userDefaults = UserDefaults.standard
}

public extension Persistence {
    //MARK: - Key
    
    /// Ключи, по которым осуществляется поиск данных в `UserDefaults`
    enum Key: String {
        case isOnboarded
        case favorites
        case card
        case searchHistory
        case userToken
    }
    
    //MARK: - Properties
    
    /// Прошел-ли пользователь онбординг.
    var isOnboarded: Bool {
        get { userDefaults.boolForKey(.isOnboarded) }
        set { userDefaults.setValue(newValue, forKey: .isOnboarded) }
    }
    
    /// `id` продуктов, добавленных в избранное.
    ///
    /// - important: Установка данного свойства с использованием пустой коллекцией, равносильна установке `nil`.
    var favorites: Set<Int>? {
        get {
            userDefaults
                .arrayForKey(.favorites)
                .flatMap { $0 as? [Int] }
                .map { $0.uniqued() }
        }
        set {
            userDefaults.setValue(
                newValue.filter(!\.isEmpty).map(Array.init),
                forKey: .favorites
            )
        }
    }
    
    /// Список товаров в корзине пользователя.
    ///
    /// Ключем является  `id` товара, тогда как значение отражает кол-во данного товара в корзине.
    ///
    /// - important: Установка данного свойства с использованием пустой коллекцией, равносильна установке `nil`.
    var card: [Int : Int]? {
        get {
            userDefaults
                .dictionaryForKey(.card)?
                .reduce(into: [Int : Int](), { partialResult, pair in
                    guard let id = Int(pair.key), let count = pair.value as? Int else {
                        return
                    }
                    partialResult[id] = count
                })
        }
        set {
            let udObj = newValue?.reduce(into: [String: Int](), { partialResult, pair in
                partialResult[pair.key.description] = pair.value
            })
            userDefaults.setValue(
                udObj.filter(!\.isEmpty),
                forKey: .card
            )
        }
    }
    
    /// История поиска.
    ///
    /// - important: Установка данного свойства с использованием пустой коллекцией, равносильна установке `nil`.
    var searchHistory: [String]? {
        get { userDefaults.stringArrayForKey(.searchHistory) }
        set { userDefaults.setValue(newValue.filter(!\.isEmpty), forKey: .searchHistory) }
    }
    
    /// Токен авторизации текущего пользователя.
    ///
    /// - important: Установка данного свойства с использованием пустой строки, равносильна установке `nil`.
    var userToken: String? {
        get { userDefaults.string(forKey: Persistence.Key.userToken.rawValue) }
        set { userDefaults.setValue(newValue.filter(!\.isEmpty), forKey: .userToken) }
    }
}

extension UserDefaults: @unchecked @retroactive Sendable {
    @inlinable
    func setValue(_ value: Any?, forKey key: Persistence.Key) {
        self.setValue(value, forKey: key.rawValue)
    }
    
    @inlinable
    func boolForKey(_ key: Persistence.Key) -> Bool {
        self.bool(forKey: key.rawValue)
    }

    @inlinable
    func arrayForKey(_ key: Persistence.Key) -> [Any]? {
        self.array(forKey: key.rawValue)
    }
    
    @inlinable
    func dictionaryForKey(_ key: Persistence.Key) -> [String : Any]? {
        self.dictionary(forKey: key.rawValue)
    }
    
    @inlinable
    func stringArrayForKey(_ key: Persistence.Key) -> [String]? {
        self.stringArray(forKey: key.rawValue)
    }
}
