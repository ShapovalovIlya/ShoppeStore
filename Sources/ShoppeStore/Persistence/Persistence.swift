//
//  Persistence.swift
//  ShoppeStore
//
//  Created by Илья Шаповалов on 09.03.2025.
//

import Foundation

public final class Persistence: Sendable {
    private let userDefaults = UserDefaults.standard
}

public extension Persistence {
    //MARK: - Key
    enum Key: String {
        case isOnboarded
        case favorites
        case card
        case searchHistory
    }
    
    //MARK: - Properties
    var isOnboarded: Bool {
        get { userDefaults.boolForKey(.isOnboarded) }
        set { userDefaults.setValue(newValue, forKey: .isOnboarded) }
    }
    
    var favorites: Set<Int>? {
        get {
            userDefaults
                .arrayForKey(.favorites)
                .flatMap { $0 as? [Int] }
                .map { $0.uniqued() }
        }
        set { userDefaults.setValue(newValue.map(Array.init), forKey: .favorites) }
    }
    
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
            userDefaults.setValue(udObj, forKey: .card)
        }
    }
    
    var searchHistory: [String]? {
        get { userDefaults.stringArrayForKey(.searchHistory) }
        set { userDefaults.setValue(newValue, forKey: .searchHistory) }
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
