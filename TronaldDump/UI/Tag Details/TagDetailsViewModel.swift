//
//  TagDetailsViewModel.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import BrightFutures

protocol TagDetailsViewModelDelegate: AnyObject, ShowsError {
    func reload()
}

class TagDetailsViewModel {
    enum Item: Equatable {
        case loading
        case tagDetails(TagDetailsCellViewModel)
    }

    private let tagName: TagName
    private let actions: TagActions
    private let flow: TagFlow
    private var nextLink: String?
    private var initialLoading = true

    private let threadingModel: ThreadingModel
    private var context: ExecutionContext { return threadingModel() }

    weak var delegate: TagDetailsViewModelDelegate?
    private(set) var items: [Item] = []
    let title: String
    var itemsWithLoadingCount: Int {
        guard !initialLoading else { return 1 }

        let addLoading = nextLink != nil ? 1 : 0
        return items.count + addLoading
    }

    init(tagName: TagName, flow: TagFlow, actions: TagActions, threadingModel: @escaping ThreadingModel = DefaultThreadingModel) {
        title = tagName
        self.tagName = tagName
        self.actions = actions
        self.flow = flow
        self.threadingModel = threadingModel
    }

    func start() {
        actions.getDetails(for: tagName).onComplete(context) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(tagDetails):
                strongSelf.initialLoading = false
                strongSelf.items = tagDetails.details.map { .tagDetails(TagDetailsCellViewModel(tag: $0)) }
                strongSelf.nextLink = tagDetails.nextLink
                strongSelf.delegate?.reload()
            case let .failure(error):
                strongSelf.delegate?.show(error: error)
            }
        }
    }

    func isLoading(for index: IndexPath) -> Bool {
        if initialLoading {
            return true
        } else {
            return index.row >= items.count
        }
    }

    func loadNext() {
        guard let next = nextLink else { return }
        actions.getDetails(on: next).onComplete(context) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(tagDetails):
                strongSelf.items.removeAll(where: { $0 == Item.loading })
                let newItems = tagDetails.details.map { Item.tagDetails(TagDetailsCellViewModel(tag: $0)) }
                strongSelf.items.append(contentsOf: newItems)
                strongSelf.nextLink = tagDetails.nextLink
                strongSelf.delegate?.reload() //improvement: better way of dealing with adding items instead of reloading
            case let .failure(error):
                strongSelf.delegate?.show(error: error)
            }
        }
    }

    func selectTag(at index: Int) {
        guard case let .tagDetails(details) = items[index],
            let url = details.source else { return }
            flow.gotoTagDetailsSource(url: url)
    }

}
