//  Copyright © 2019 ACartagena. All rights reserved.

import CoreData
import Foundation

extension TagDetailsData {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TagDetailsData> {
        return NSFetchRequest<TagDetailsData>(entityName: "TagDetailsData")
    }

    @NSManaged public var value: String
    @NSManaged public var appearedAt: NSDate
    @NSManaged public var author: String?
    @NSManaged public var source: String?
    @NSManaged public var tags: NSSet
}

// MARK: Generated accessors for tags

extension TagDetailsData {
    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: TagData)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: TagData)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)
}
