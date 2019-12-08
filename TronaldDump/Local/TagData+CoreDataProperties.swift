//  Copyright © 2019 ACartagena. All rights reserved.

import CoreData
import Foundation

extension TagData {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TagData> {
        return NSFetchRequest<TagData>(entityName: "TagData")
    }

    @NSManaged public var name: String
    @NSManaged public var details: NSSet?
}

// MARK: Generated accessors for details

extension TagData {
    @objc(addDetailsObject:)
    @NSManaged public func addToDetails(_ value: TagDetailsData)

    @objc(removeDetailsObject:)
    @NSManaged public func removeFromDetails(_ value: TagDetailsData)

    @objc(addDetails:)
    @NSManaged public func addToDetails(_ values: NSSet)

    @objc(removeDetails:)
    @NSManaged public func removeFromDetails(_ values: NSSet)
}
