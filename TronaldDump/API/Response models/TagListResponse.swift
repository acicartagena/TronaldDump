//  Copyright © 2019 ACartagena. All rights reserved.

import Foundation

struct TagListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }

    let embedded: [String]
}

extension TagListResponse {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        embedded = try container.decode([String].self, forKey: .embedded)
    }
}
