//  Copyright © 2019 ACartagena. All rights reserved.

import Foundation

extension TagDetails {
    init(localData: [TagDetailsData]) {
        details = localData.map { TagDetails.Details(localData: $0) }
        nextLink = nil
    }
}

extension TagDetails.Details {
    init(localData: TagDetailsData) {
        tags = [localData.tag]
        value = localData.value
        appearedAt = localData.appearedAt as Date
        author = localData.author.map { Author(name: $0) }
        source = localData.source.map { Source(localData: $0) } ?? nil
    }
}

extension TagDetails.Details.Source {
    init?(localData: String) {
        guard let url = URL(string: localData) else { return nil }
        self.url = url
    }
}
