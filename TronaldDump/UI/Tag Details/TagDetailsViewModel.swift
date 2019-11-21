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

    let tagName: TagName
    private let tagsActions: TagActions
    private var tagDetails: TagDetails?
    weak var delegate: TagDetailsViewModelDelegate?

    private(set) var items: [Item] = []

    init(tagName: TagName, tagsActions: TagActions) {
        self.tagName = tagName
        self.tagsActions = tagsActions
    }

    func start() {
        items = [.loading]
        tagsActions.getDetails(for: tagName).onComplete {[weak self] result in
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
}
