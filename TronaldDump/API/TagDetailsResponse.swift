//
//  TagDetails.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

struct TagDetailsResponse: Decodable {
    struct Embedded: Decodable {
        let tags: [TagDetails]
    }

    struct Links: Decodable {
        struct Link: Decodable {
            let href: String
        }
        let prev: Link?
        let next: Link?
        let first: Link?
        let last: Link?
        let `self`: Link?
    }

    struct TagDetails: Decodable {
        enum CodingKeys: String, CodingKey {
            case embedded = "_embedded"
            case tags
            case value
            case appearedAt
        }

        struct Embedded: Decodable {
            let author: [Author]
            let source: [Source]
        }

        struct Author: Decodable {
            let name: String
        }

        struct Source: Decodable  {
            let url: String
        }

        let tags: [String]
        let value: String
        let appearedAt: Date
        let embedded: Embedded
    }

    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case links = "_links"
        case total
    }

    let total: Int
    let links: Links
    let embedded: Embedded
}

extension TagDetailsResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        embedded = try container.decode(Embedded.self, forKey: .embedded)
        links = try container.decode(Links.self, forKey: .links)
        total = try container.decode(Int.self, forKey: .total)
    }
}

extension TagDetailsResponse.TagDetails {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        tags = try container.decode([String].self, forKey: .tags)
        value = try container.decode(String.self, forKey: .value)
        appearedAt = try container.decode(Date.self, forKey: .appearedAt)
        embedded = try container.decode(Embedded.self, forKey: .embedded)
    }
}

