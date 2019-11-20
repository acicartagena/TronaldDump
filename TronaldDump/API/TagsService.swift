//
//  TagService.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import BrightFutures

protocol TagsActions {
    func getTags() -> Future<[TagName], TronaldDumpError>
    func getDetails(for tag: TagName)
}

class TagsService: TagsActions {

    let networking = Networking()

    func getTags() -> Future<[TagName], TronaldDumpError> {
        let url = URL(string: "https://api.tronalddump.io/tag")!
        let tagListResponse: Future<TagListResponse, TronaldDumpError> = networking.get(url: url)
        return tagListResponse.map { return $0._embedded }
    }

    func getDetails(for tag: TagName) {

    }
}
