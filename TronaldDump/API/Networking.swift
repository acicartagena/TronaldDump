//
//  Networking.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import BrightFutures

enum TronaldDumpError: Error {
    case networking(Error)
    case decoding(Error)
    case invalidURL(String)
    case noData
    case other(Error)
}

class Networking {
    let session = URLSession(configuration: .default)
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(DateFormatter.custom)
        return decoder
    }()

    func get<T:Decodable>(url: URL) -> Future<T,TronaldDumpError> {
        let promise = Promise<T,TronaldDumpError>()

        session.dataTask(with: url) { [weak self] (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    promise.failure(.networking(error))
                    return
                }

                guard let data = data, let strongSelf = self else {
                    promise.failure(.noData)
                    return
                }

                do {
                    let decoded = try strongSelf.decoder.decode(T.self, from: data)
                    promise.success(decoded)
                } catch let error {
                    promise.failure(.decoding(error))
                    return
                }
            }
        }
        .resume()
        return promise.future
    }
}
