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
    case other(Error)
}

class Networking {
    let session = URLSession(configuration: .default)
    func get<T:Decodable>(url: URL) -> Future<T,TronaldDumpError> {
        let promise = Promise<T,TronaldDumpError>()

        session.dataTask(with: url) { (data, urlResponse, error) in

        }
        .resume()

        return promise.future
    }

}
