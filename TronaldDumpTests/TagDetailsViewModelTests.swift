//
//  TagDetailsViewModelTests.swift
//  TronaldDumpTests
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import BrightFutures
@testable import TronaldDump
import XCTest

class TagDetailsViewModelTests: XCTestCase {
    var delegateCalls: [String] = []
    var flow: TagFlowSpy!
    var actions: TagActionsStub!

    override func setUp() {
        super.setUp()
        delegateCalls = []
        flow = TagFlowSpy()
        actions = TagActionsStub()
    }

    func getSubject(for tagName: String) -> TagDetailsViewModel {
        let subject = TagDetailsViewModel(tagName: tagName, flow: flow, actions: actions, threadingModel: { ImmediateExecutionContext })
        subject.delegate = self
        return subject
    }

    func testInitItems() {
        let subject = getSubject(for: "tag1")

        XCTAssertEqual(subject.items, [])
        XCTAssertEqual(subject.itemsWithLoadingCount, 1)

        XCTAssertTrue(subject.isLoading(for: IndexPath(row: 2, section: 0)))
        XCTAssertTrue(subject.isLoading(for: IndexPath(row: 0, section: 0)))
    }

    func testStartError() {
        actions.getDetailsForTag = .failure(.noData)

        let subject = getSubject(for: "tag1")
        subject.start()

        XCTAssertEqual(subject.items, [])
        XCTAssertEqual(delegateCalls, ["showError: noData"])
    }

    func testStart() {
        let tagDetails = TagDetails.Details(tags: ["tag"],
                                            value: "Hello",
                                            appearedAt: Date(),
                                            author: TagDetails.Details.Author(name: "Me, myself & I"),
                                            source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        actions.getDetailsForTag = .success(TagDetails(details: [tagDetails], nextLink: "next.com"))

        let subject = getSubject(for: "tag1")
        subject.start()

        XCTAssertEqual(subject.items, [.tagDetails(TagDetailsCellViewModel(tag: tagDetails))])
        XCTAssertEqual(subject.itemsWithLoadingCount, 2)

        XCTAssertFalse(subject.isLoading(for: IndexPath(row: 0, section: 0)))
        XCTAssertTrue(subject.isLoading(for: IndexPath(row: 1, section: 0)))
    }

    func testStartNoNext() {
        let tagDetails = TagDetails.Details(tags: ["tag"],
                                            value: "Hello",
                                            appearedAt: Date(),
                                            author: TagDetails.Details.Author(name: "Me, myself & I"),
                                            source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        actions.getDetailsForTag = .success(TagDetails(details: [tagDetails], nextLink: nil))

        let subject = getSubject(for: "tag1")
        subject.start()

        XCTAssertEqual(subject.items, [.tagDetails(TagDetailsCellViewModel(tag: tagDetails))])
        XCTAssertEqual(subject.itemsWithLoadingCount, 1)
        XCTAssertFalse(subject.isLoading(for: IndexPath(row: 0, section: 0)))
    }

    func testLoadNext() {
        let tagDetails = TagDetails.Details(tags: ["tag"],
                                            value: "Hello",
                                            appearedAt: Date(),
                                            author: TagDetails.Details.Author(name: "Me, myself & I"),
                                            source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        let nextTagDetails = TagDetails.Details(tags: ["tag2"],
                                                value: "Next",
                                                appearedAt: Date(),
                                                author: TagDetails.Details.Author(name: "anonymous"),
                                                source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))

        actions.getDetailsForTag = .success(TagDetails(details: [tagDetails], nextLink: "next.com"))
        actions.getDetailsOnNext = .success(TagDetails(details: [nextTagDetails], nextLink: "more.com"))

        let subject = getSubject(for: "tag1")
        subject.start()
        subject.loadNext()

        XCTAssertEqual(subject.items, [.tagDetails(TagDetailsCellViewModel(tag: tagDetails)), .tagDetails(TagDetailsCellViewModel(tag: nextTagDetails))])
        XCTAssertEqual(subject.itemsWithLoadingCount, 3)
        XCTAssertTrue(subject.isLoading(for: IndexPath(row: 2, section: 0)))
        XCTAssertFalse(subject.isLoading(for: IndexPath(row: 1, section: 0)))
    }

    func testLoadNextNoNext() {
        let tagDetails = TagDetails.Details(tags: ["tag"],
                                            value: "Hello",
                                            appearedAt: Date(),
                                            author: TagDetails.Details.Author(name: "Me, myself & I"),
                                            source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        let nextTagDetails = TagDetails.Details(tags: ["tag2"],
                                                value: "Next",
                                                appearedAt: Date(),
                                                author: TagDetails.Details.Author(name: "anonymous"),
                                                source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))

        actions.getDetailsForTag = .success(TagDetails(details: [tagDetails], nextLink: "next.com"))
        actions.getDetailsOnNext = .success(TagDetails(details: [nextTagDetails], nextLink: nil))

        let subject = getSubject(for: "tag1")
        subject.start()
        subject.loadNext()

        XCTAssertEqual(subject.items, [.tagDetails(TagDetailsCellViewModel(tag: tagDetails)), .tagDetails(TagDetailsCellViewModel(tag: nextTagDetails))])
        XCTAssertEqual(subject.itemsWithLoadingCount, 2)
        XCTAssertFalse(subject.isLoading(for: IndexPath(row: 1, section: 0)))
    }

    func testSelectTag() {
        let tagDetails = TagDetails.Details(tags: ["tag"],
                                            value: "Hello",
                                            appearedAt: Date(),
                                            author: TagDetails.Details.Author(name: "Me, myself & I"),
                                            source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        actions.getDetailsForTag = .success(TagDetails(details: [tagDetails], nextLink: "next.com"))

        let subject = getSubject(for: "tag1")
        subject.start()

        subject.selectTag(at: 0)

        XCTAssertEqual(flow.calls, ["gotoTagDetailsSource: \(URL(string: "http://www.google.com")!)"])
    }
}

extension TagDetailsViewModelTests: TagDetailsViewModelDelegate {
    func reload() {
        delegateCalls.append("reload")
    }

    func show(error: TronaldDumpError) {
        delegateCalls.append("showError: \(error)")
    }
}
