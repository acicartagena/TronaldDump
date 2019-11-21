//
//  DateFormatter+iso8601Full.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

extension DateFormatter {
    static let decodeDateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    static let displayDateFormat = "dd MMM yyyy HH:mm a"

    static let custom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.decodeDateFormat
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
