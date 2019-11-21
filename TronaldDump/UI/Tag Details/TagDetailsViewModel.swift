//
//  TagDetailsViewModel.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation

protocol TagDetailsViewModelDelegate: AnyObject, ShowsError { }

class TagDetailsViewModel {
    enum Item {
        case loading
        case tag(TagName)
    }

    let tagName: TagName
    private let tagsActions: TagActions
    private var tagDetails: TagDetails?
    weak var delegate: TagDetailsViewModelDelegate?

    init(tagName: TagName, tagsActions: TagActions) {
        self.tagName = tagName
        self.tagsActions = tagsActions
    }

    func start() {
        tagsActions.getDetails(for: tagName).onComplete {[weak self] result in
            switch result {
            case let .success(tagDetails): self?.tagDetails = tagDetails
                print(tagDetails)
            case let .failure(error): print(error)

            }
        }
    }
}
