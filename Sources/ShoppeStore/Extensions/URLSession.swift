//
//  URLSession.swift
//  ShoppeNetworking
//
//  Created by Илья Шаповалов on 03.03.2025.
//

import Foundation
import FoundationFX
import Readers

extension Result where Success == (data: Data, response: URLResponse) {
    @inlinable
    func validateStatus(_ validCodes: ClosedRange<Int>) -> Result<Data, Error> {
        tryMap { data, response in
            guard let httpResp = response as? HTTPURLResponse else {
                throw URLError(.badServerResponse, userInfo: ["response": response])
            }
            guard validCodes.contains(httpResp.statusCode) else {
                throw URLError(.badServerResponse, userInfo: ["statusCode": httpResp.statusCode])
            }
            return data
        }
    }
}

extension Result where Success: Encodable {
    @inlinable
    func encodeJSON(_ encoder: JSONEncoder) -> Result<Data, Error> {
        tryMap { try encoder.encode($0) }
    }
}

extension URLSession {
    typealias Response = Result<Data, Error>
    typealias RequestBuilder = AsyncReader<Request, Response>
    
    func request(_ endpoint: Endpoint) -> RequestBuilder {
        RequestBuilder { request in
            await endpoint.url()
                .map(request.apply(_:))
                .asyncFlatMap(self.result(for:))
                .validateStatus(200...299)
        }
    }
    
    func imageFrom(_ url: URL) async -> Result<Data, Error> {
        await self.result(from: url)
            .validateStatus(200...299)
    }
}
