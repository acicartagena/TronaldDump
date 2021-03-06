//  Copyright © 2019 ACartagena. All rights reserved.

import CoreData
import Foundation

class LocalStorage {
    let container: NSPersistentContainer = NSPersistentContainer(name: "TronaldDump")

    init() {
        container.loadPersistentStores { _, error in
            if let error = error {
                print("local storage error: \(error)") // improvement: send error over to a logging/monitoring service
            }
        }
    }

    func saveContext() {
        guard container.viewContext.hasChanges else { return }
        do {
            try container.viewContext.save()
        } catch {
            print("error saving: \(error)") // improvement: send error over to a logging/monitoring service
        }
    }
}
