//
//  TagsViewModelTests.swift
//  TronaldDumpTests
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import XCTest
import BrightFutures
@testable import TronaldDump

class TagsViewModelTests: XCTestCase {

    var delegateCalls: [String] = []
    var flow: TagFlowSpy!
    var actions: TagActionsStub!
    var subject: TagsViewModel!

    override func setUp() {
        super.setUp()

        delegateCalls = []
        flow = TagFlowSpy()
        actions = TagActionsStub()
        subject = TagsViewModel(flow: flow, actions: actions, threadingModel: { ImmediateExecutionContext })
        subject.delegate = self
    }

    func testInitItems() {
        let expectedItems: [TagsViewModel.Item] = [.loading]
        XCTAssertEqual(subject.items, expectedItems)
    }

    func testStart() {
        let expectedItems: [TagsViewModel.Item] = [.tag("tag1"), .tag("tag2"), .tag("tag3")]
        actions.getTagsResult = .success(["tag1", "tag2", "tag3"])
        subject.start()

        XCTAssertEqual(subject.items, expectedItems)
    }

    func testError() {
        actions.getTagsResult = .failure(.noData)
        subject.start()

        XCTAssertEqual(subject.items, [.loading])
        XCTAssertEqual(delegateCalls, ["showError: noData"])
    }

    func testSelectItem() {
        actions.getTagsResult = .success(["tag1", "tag2", "tag3"])
        subject.start()

        subject.selected(tag: "tag2")

        XCTAssertEqual(flow.calls, ["gotoDetails: tag2"])
    }
}

extension TagsViewModelTests: TagsViewModelDelegate {
    func reload() {
        delegateCalls.append("reload")
    }

    func show(error: TronaldDumpError) {
        delegateCalls.append("showError: \(error)")
    }
}
