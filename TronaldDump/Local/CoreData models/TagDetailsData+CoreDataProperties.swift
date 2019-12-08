//  Copyright © 2019 ACartagena. All rights reserved.

import CoreData
import Foundation

extension TagDetailsData {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TagDetailsData> {
        return NSFetchRequest<TagDetailsData>(entityName: "TagDetailsData")
    }

    @NSManaged public var appearedAt: NSDate
    @NSManaged public var author: String?
    @NSManaged public var source: String?
    @NSManaged public var value: String
    @NSManaged public var tag: String
}
