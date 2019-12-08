//  Copyright © 2019 ACartagena. All rights reserved.

import BrightFutures
import Foundation

enum LocalStorageError: Error {
    case fetchFailed
    case saveFailed
}

protocol TronaldDumpLocal {
    func loadTags() -> Future<[TagData], LocalStorageError>
    func loadDetails(for tag: String) -> Future<[TagDetailsData], LocalStorageError>
    func save(tags: [String])
    func save(tagDetails: [TagDetails.Details])
}

class TronaldDumpLocalStorage: LocalStorage {
    func loadTags() -> Future<[TagData], LocalStorageError> {
        let promise = Promise<[TagData], LocalStorageError>()
        let request = TagData.createFetchRequest()
        do {
            let tags = try container.viewContext.fetch(request)
            promise.success(tags)
        } catch {
            promise.failure(.fetchFailed)
        }
        return promise.future
    }

    func loadDetails(for tag: String) -> Future<[TagDetailsData], LocalStorageError> {
        let promise = Promise<[TagDetailsData], LocalStorageError>()
        let tagInTagsPredicate = NSPredicate(format: "tag = %@", tag)
        let request = TagDetailsData.createFetchRequest()
        request.predicate = tagInTagsPredicate
        do {
            let tagDetails = try container.viewContext.fetch(request)
            promise.success(tagDetails)
        } catch {
            promise.failure(.fetchFailed)
        }
        return promise.future
    }

    func save(tags: [String]) {
        DispatchQueue.main.async {
            for tag in tags {
                let tagData = TagData(context: self.container.viewContext)
                tagData.name = tag
            }
            self.saveContext()
        }
    }

    func save(tagDetails: [TagDetails.Details], for tag: String) {
        DispatchQueue.main.async {
            for detail in tagDetails {
                let tagDetailsData = TagDetailsData(context: self.container.viewContext)
                tagDetailsData.value = detail.value
                tagDetailsData.appearedAt = detail.appearedAt as NSDate
                tagDetailsData.author = detail.author?.name
                tagDetailsData.source = detail.source?.url.absoluteString
                tagDetailsData.tag = tag
            }
            self.saveContext()
        }
    }
}
