//
//  Networking.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

struct HTTPError {
    let description: String
    let statusCode: Int
}

extension HTTPError {
    init(response: HTTPURLResponse) {
        let statusCode = response.statusCode
        self.statusCode = statusCode
        description = HTTPURLResponse.localizedString(forStatusCode: statusCode)
    }
}

enum NetworkingError: Error {
    case request(Error)
    case httpError(HTTPError)
    case noData
}

extension NetworkingError {
    var localizedDescription: String {
        switch self {
        case let .request(error): return error.localizedDescription
        case let .httpError(error): return error.description
        case .noData: return NSLocalizedString("No data found", comment: "")
        }
    }
}

class Networking {
    let session = URLSession(configuration: .default)

    func request(urlRequest: URLRequest, completionHandler: @escaping (Result<Data, NetworkingError>) -> Void) {
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(.failure(.request(error)))
                return
            }

            let validStatusCodes = 200 ..< 300
            if let httpResponse = response as? HTTPURLResponse,
                !validStatusCodes.contains(httpResponse.statusCode) {
                let httpError = HTTPError(response: httpResponse)
                completionHandler(.failure(.httpError(httpError)))
                return
            }

            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }

            return completionHandler(.success(data))
        }
        .resume()
    }
}
