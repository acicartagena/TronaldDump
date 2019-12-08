//  Copyright © 2019 ACartagena. All rights reserved.

import BrightFutures
import Foundation

protocol TagActions {
    func getTags() -> Future<[TagName], TronaldDumpError>
    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError>
    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError>
}
