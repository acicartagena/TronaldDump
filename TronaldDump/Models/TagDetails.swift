//
//  Tag.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

typealias TagName = String

struct TagDetails {
    struct Details {
        struct Author: Decodable {
            let name: String
        }

        struct Source: Decodable  {
            let url: URL
        }

        let tags: [TagName]
        let value: String
        let appearedAt: Date
        let author: Author?
        let source: Source?
    }

    let details: [Details]
    let nextLink: String?
    let total: Int
}

extension TagDetails {
    init(response: TagDetailsResponse) {
        details = response.embedded.tags.map { TagDetails.Details(response: $0) }
        nextLink = response.links.next?.href
        total = response.total
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
        guard let url =  URL(string: response.url) else { return nil }
        self.url = url
    }
}
