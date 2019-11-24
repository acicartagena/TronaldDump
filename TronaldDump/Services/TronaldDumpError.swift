//
//  TronaldDumpAPI.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 24/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

enum TronaldDumpError: Error {
    case show(String)

    init(apiError: APIError) {
        print(apiError)
        self = .show(apiError.localizedDescription)
    }

    var displayString: String {
        guard case let .show(errorString) = self else {
            return NSLocalizedString("Something went wrong", comment: "")
        }
        return errorString
    }
}
