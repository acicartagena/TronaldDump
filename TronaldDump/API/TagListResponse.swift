//
//  TagList.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

struct TagListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
        case count
        case total
    }

    let count: Int
    let total: Int
    let embedded: [String]
}

extension TagListResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        embedded = try container.decode([String].self, forKey: .embedded)
        count = try container.decode(Int.self, forKey: .count)
        total = try container.decode(Int.self, forKey: .total)
    }
}
