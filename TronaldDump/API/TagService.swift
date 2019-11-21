//
//  TagService.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import BrightFutures

protocol TagActions {
    func getTags() -> Future<[TagName], TronaldDumpError>
    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError>
    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError>
}

class TagService: TagActions {
    let networking = Networking()

    func getTags() -> Future<[TagName], TronaldDumpError> {
        let urlString = "https://api.tronalddump.io/tag"
        guard let url = URL(string: urlString) else {
            return Future(error: .invalidURL(urlString))
        }
        let tagListResponse: Future<TagListResponse, TronaldDumpError> = networking.get(url: url)
        return tagListResponse.map { return $0.embedded }
    }

    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError> {
        let tagEncoding = tag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? tag
        let urlString = "https://api.tronalddump.io/tag/\(tagEncoding)"
        guard let url = URL(string: urlString) else {
                return Future(error: .invalidURL(urlString))
        }
        let tagDetailsResponse: Future<TagDetailsResponse, TronaldDumpError> = networking.get(url: url)
        return tagDetailsResponse.map { return TagDetails(response: $0) }
    }

    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError> {
        let urlString = "https://api.tronalddump.io\(next)"
        guard let url = URL(string: urlString) else {
            return Future(error: .invalidURL(urlString))
        }
        let tagDetailsResponse: Future<TagDetailsResponse, TronaldDumpError> = networking.get(url: url)
        return tagDetailsResponse.map { return TagDetails(response: $0) }
    }
}
