//
//  TagDetails.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

struct TagDetailsResponse: Decodable {
    struct Embedded {
        let tags: [TagDetails]
    }

    let _embedded: Embedded

}

struct TagDetails: Decodable {
    struct Embedded {
        let author: [Author]
        let source: [Source]
    }
    let tags: [TagName]
    let value: String
    let _embedded: Embedded
}

struct Author: Decodable {

}

struct Source: Decodable  {

}
