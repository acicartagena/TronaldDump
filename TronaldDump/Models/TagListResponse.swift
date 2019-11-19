//
//  TagList.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

typealias TagName = String

struct TagListResponse: Decodable {
    let count: Int
    let total: Int
    let _embedded: [TagName]
}
