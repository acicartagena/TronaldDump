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
    struct Author: Decodable {
        let name: String
    }

    struct Source: Decodable  {
        let url: String
    }

    let tags: [TagName]
    let value: String
    let createdAt: Date
    let author: Author
    let source: Source
}
