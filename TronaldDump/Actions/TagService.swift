//  Copyright © 2019 ACartagena. All rights reserved.

import BrightFutures
import Foundation

class TagService {
    private let api = TronaldDumpAPI()
    private let local = TronaldDumpLocalStorage()
}

extension TagService: TagActions {
    func getTags() -> Future<[TagName], TronaldDumpError> {
        let request = api.getTags()
            .mapError { TronaldDumpError(apiError: $0) }
            .map { $0.embedded }

        request
            .onSuccess { [weak self] tags in
                self?.local.save(tags: tags)
            }

        let cachedResult = request
            .recoverWith { [weak self] error -> Future<[TagName], TronaldDumpError> in
                guard let self = self else { return request }
                return self.local.loadTags()
                    .map { $0.map { return $0.name } }
                    .mapError { _ in return error }
            }

        return cachedResult
    }

    func getDetails(for tag: TagName) -> Future<TagDetails, TronaldDumpError> {
        let request = api.getDetails(for: tag)
            .mapError { TronaldDumpError(apiError: $0) }
            .map { TagDetails(response: $0) }

        request.onSuccess { [weak self] tagDetails in
            self?.local.save(tagDetails: tagDetails.details, for: tag)
        }

        let cachedResult = request.recoverWith { [weak self]  error -> Future<TagDetails, TronaldDumpError> in
            guard let self = self else { return request }
            return self.local.loadDetails(for: tag)
                .map { return TagDetails(localData: $0) }
                .mapError { _ in return error }
        }

        return cachedResult
    }

    func getDetails(on next: String) -> Future<TagDetails, TronaldDumpError> {
        return api.getDetails(on: next)
            .mapError { TronaldDumpError(apiError: $0) }
            .map { TagDetails(response: $0) }
    }
}
