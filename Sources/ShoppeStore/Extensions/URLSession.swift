//
//  URLSession.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation
import FoundationFX

extension URLSession {
    func parseResponse(data: Data, response: URLResponse) -> Result<Data, Error> {
        Result {
            guard let httpResp = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse, userInfo: ["invalidType": response])
            }
            guard (200...299).contains(httpResp.statusCode) else {
                throw URLError(.badServerResponse, userInfo: ["badCode": httpResp.statusCode])
            }
            return data
        }
    }
    
    func resultFrom(
        _ method: Request.Method,
        endpoint: Endpoint
    ) async -> Result<Data, Error> {
        await endpoint.url()
            .map(Request.new.method(method).apply(_:))
            .asyncFlatMap(self.result(for:))
            .flatMap(parseResponse)
    }
    
    func imageFrom(_ url: URL) async -> Result<Data, Error> {
        await self.result(from: url)
            .flatMap(parseResponse)
    }
}
