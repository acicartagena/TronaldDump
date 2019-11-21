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

extension TronaldDumpError {
    var displayString: String {
        switch self {
        case let .decoding(error):
            print(error) //improvement: send error to logging/non-fatal error service
            return NSLocalizedString("Decoding error", comment: "")
        case let .invalidURL(url):
            print("invalid URL: \(url)") //improvement: send error to logging/non-fatal error service
            return NSLocalizedString("Invalid URL: \(url)", comment: "")
        case let .networking(error):
            print(error) //improvement: send error to logging/non-fatal error service
            return NSLocalizedString("Networking error", comment: "")
        case .noData:
            print("no data") //improvement: send error to logging/non-fatal error service
            return NSLocalizedString("Something went wrong...", comment: "")
        case let .other(error):
            print(error) //improvement: send error to logging/non-fatal error service
            return NSLocalizedString("Something went wrong...", comment: "")
        }
    }
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
