//
//  TagDetailsViewModel.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

protocol TagDetailsViewModelDelegate: AnyObject, ShowsError {
    func reload()
}

class TagDetailsViewModel {
    enum Item {
        case loading
        case tagDetails(TagDetailsCellViewModel)
    }

    private let tagName: TagName
    private let actions: TagActions
    private var tagDetails: TagDetails?
    private let flow: TagFlow

    weak var delegate: TagDetailsViewModelDelegate?
    private(set) var items: [Item] = []
    let title: String

    init(tagName: TagName, flow: TagFlow, actions: TagActions) {
        title = tagName
        self.tagName = tagName
        self.actions = actions
        self.flow = flow
    }

    func start() {
        items = [.loading]
        actions.getDetails(for: tagName).onComplete {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(tagDetails):
                self?.tagDetails = tagDetails
                strongSelf.items = tagDetails.details.map { .tagDetails(TagDetailsCellViewModel(tag: $0)) }
                strongSelf.delegate?.reload()
                print(tagDetails)
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
