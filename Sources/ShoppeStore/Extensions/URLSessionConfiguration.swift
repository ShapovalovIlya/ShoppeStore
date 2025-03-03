//
//  URLSessionConfiguration.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation

extension URLSessionConfiguration {
    static var imageSession: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache(
            memoryCapacity: 50 * 1024,
            diskCapacity: 50 * 1024
        )
        config.timeoutIntervalForResource = 60
        return config
    }
    
    static var dataSession: URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache(
            memoryCapacity: 20 * 1024,
            diskCapacity: 20 * 1024
        )
        config.timeoutIntervalForResource = 60
        return config
    }
}
