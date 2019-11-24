//
//  API.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 24/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import BrightFutures
import Foundation

enum HTTPMethods: String {
    case get
}

enum APIError: Error {
    case networking(NetworkingError)
    case decoding(Error)
    case invalidURL(String)
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case let .networking(error): return error.localizedDescription
        case let .decoding(error): return error.localizedDescription
        case let .invalidURL(error): return NSLocalizedString("Invalid url: \(error)", comment: "")
        }
    }
}

class API {
    private let networking = Networking()

    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
        return decoder
    }()

    func get<T: Decodable>(url: URL) -> Future<T, APIError> {
        let promise = Promise<T, APIError>()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.get.rawValue
        networking.request(urlRequest: urlRequest) { result in
            switch result {
            case let .success(data):
                do {
                    let decoded = try API.decoder.decode(T.self, from: data)
                    return promise.success(decoded)
                } catch {
                    return promise.failure(.decoding(error))
                }
            case let .failure(error):
                promise.failure(APIError.networking(error))
            }
        }
        return promise.future
    }
}
