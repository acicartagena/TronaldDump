//
//  TagService.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import BrightFutures
import Foundation

protocol TagActions {
    func getTags() -> Future<[TagName], TronaldDumpError>
    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError>
    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError>
}

class TagService: TagActions {
    private let api = TronaldDumpAPI()

    func getTags() -> Future<[TagName], TronaldDumpError> {
        return api.getTags()
            .mapError { TronaldDumpError(apiError: $0) }
            .map { $0.embedded }
    }

    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError> {
        return api.getDetails(for: tag)
            .mapError { TronaldDumpError(apiError: $0) }
            .map { TagDetails(response: $0) }
    }

    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError> {
        return api.getDetails(on: next)
            .mapError { TronaldDumpError(apiError: $0) }
            .map { TagDetails(response: $0) }
    }
}

extension TagDetails {
    init(response: TagDetailsResponse) {
        details = response.embedded.tags.map { TagDetails.Details(response: $0) }
        nextLink = response.links.next?.href
    }
}

extension TagDetails.Details {
    init(response: TagDetailsResponse.TagDetails) {
        tags = response.tags
        value = response.value
        appearedAt = response.appearedAt
        author = response.embedded.author.first.map { Author(response: $0) }
        source = response.embedded.source.first.flatMap { Source(response: $0) }
    }
}

extension TagDetails.Details.Author {
    init(response: TagDetailsResponse.TagDetails.Author) {
        name = response.name
    }
}

extension TagDetails.Details.Source {
    init?(response: TagDetailsResponse.TagDetails.Source) {
        guard let url = URL(string: response.url) else { return nil }
        self.url = url
    }
}
