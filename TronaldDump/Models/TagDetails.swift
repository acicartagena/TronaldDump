//  Copyright © 2019 ACartagena. All rights reserved.

import Foundation

typealias TagName = String

struct TagDetails {
    struct Details {
        struct Author {
            let name: String
        }

        struct Source {
            let url: URL
        }

        let tags: [TagName]
        let value: String
        let appearedAt: Date
        let author: Author?
        let source: Source?
    }

    let details: [Details]
    let nextLink: String?
}
