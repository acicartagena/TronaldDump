//
//  TagList.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

struct TagListResponse: Decodable {
    let count: Int
    let total: Int
    let _embedded: [String]
}
