//
//  TagDetailsCellViewModelTests.swift
//  TronaldDumpTests
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

@testable import TronaldDump
import XCTest

class TagDetailsCellViewModelTests: XCTestCase {
    func testCompleteFomatting() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.displayDateFormat
        let date = Date()

        let tag = TagDetails.Details(tags: ["tag"],
                                     value: "Hello",
                                     appearedAt: Date(),
                                     author: TagDetails.Details.Author(name: "Me, myself & I"),
                                     source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        let subject = TagDetailsCellViewModel(tag: tag)

        XCTAssertEqual(subject.date, dateFormatter.string(from: date))
        XCTAssertEqual(subject.quote, "\"Hello\"")
        XCTAssertEqual(subject.author, "- Me, myself & I")
        XCTAssertEqual(subject.sourceText, "www.google.com")
    }

    func testMissingAuthor() {
        let tag = TagDetails.Details(tags: ["tag"],
                                     value: "Hello",
                                     appearedAt: Date(),
                                     author: nil,
                                     source: TagDetails.Details.Source(url: URL(string: "http://www.google.com")!))
        let subject = TagDetailsCellViewModel(tag: tag)

        XCTAssertEqual(subject.author, "- unknown")
    }
}
