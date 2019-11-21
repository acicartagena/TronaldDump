//
//  TagsViewModel.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

protocol TagsViewModelDelegate: AnyObject, ShowsError {
    func reload()
}

class TagsViewModel {
    enum Item {
        case loading
        case tag(TagName)
    }

    private weak var flow: TagFlow?
    private let actions: TagActions

    private(set) var items: [Item] = []

    let title = NSLocalizedString("Tags", comment: "")
    weak var delegate: TagsViewModelDelegate?

    init(flow: TagFlow, actions: TagActions) {
        self.flow = flow
        self.actions = actions
    }

    func start() {
        items = [.loading]
        actions.getTags().onComplete { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(tags):
                strongSelf.items = tags.map { .tag($0) }
                strongSelf.delegate?.reload()
            case let .failure(error):
                strongSelf.delegate?.show(error: error)
            }
        }
    }

    func selected(tag: TagName) {
        flow?.gotoDetails(for: tag)
    }
}
