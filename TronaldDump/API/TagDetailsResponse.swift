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
        let createdAt: Date
        let _embedded: Embedded
    }

    let _embedded: Embedded
    let _links: Links
}


