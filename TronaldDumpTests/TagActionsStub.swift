//
//  TagActionsStub.swift
//  TronaldDumpTests
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import BrightFutures
@testable import TronaldDump

class TagActionsStub: TagActions {

    var getTagsResult: Result<[TagName], TronaldDumpError>!
    var getDetailsForTag: Result<TagDetails, TronaldDumpError>!
    var getDetailsOnNext: Result<TagDetails, TronaldDumpError>!

    func getTags() -> Future<[TagName], TronaldDumpError> {
        return Future(result: getTagsResult)
    }

    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError> {
        return Future(result: getDetailsForTag)
    }

    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError> {
        return Future(result: getDetailsOnNext)
    }
}
