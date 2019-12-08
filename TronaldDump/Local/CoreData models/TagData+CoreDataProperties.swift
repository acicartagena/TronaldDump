//  Copyright © 2019 ACartagena. All rights reserved.

import Foundation
import CoreData

extension TagData {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<TagData> {
        return NSFetchRequest<TagData>(entityName: "TagData")
    }

    @NSManaged public var name: String

}
