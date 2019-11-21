//
//  TagFlowSpy.swift
//  TronaldDumpTests
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
@testable import TronaldDump

class TagFlowSpy: TagFlow {

    var calls: [String] = []

    func gotoDetails(for tag: TagName) {
        calls.append("gotoDetails: \(tag)")
    }

    func gotoTagDetailsSource(url: URL) {
        calls.append("gotoTagDetailsSource: \(url)")
    }
}
