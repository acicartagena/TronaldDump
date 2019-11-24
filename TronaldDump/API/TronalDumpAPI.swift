//
//  TronalDumpAPI.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 24/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import BrightFutures
import Foundation

private let defaultBaseURLString = "https://api.tronalddump.io"

class TronaldDumpAPI: API {
    private let baseURLString: String

    init(urlString: String = defaultBaseURLString) {
        baseURLString = urlString
    }

    func getTags() -> Future<TagListResponse, APIError> {
        let urlString = "\(baseURLString)/tag"
        guard let url = URL(string: urlString) else {
            return Future(error: .invalidURL(urlString))
        }
        return get(url: url)
    }

    func getDetails(for tag: TagName) -> Future<TagDetailsResponse, APIError> {
        let tagEncoding = tag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? tag
        let urlString = "\(baseURLString)/tag/\(tagEncoding)"
        guard let url = URL(string: urlString) else {
            return Future(error: .invalidURL(urlString))
        }
        return get(url: url)
    }

    func getDetails(on next: String) -> Future<TagDetailsResponse, APIError> {
        let urlString = "\(baseURLString)\(next)"
        guard let url = URL(string: urlString) else {
            return Future(error: .invalidURL(urlString))
        }
        return get(url: url)
    }
}
