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
    let tagName: TagName
    private let tagsActions: TagsActions
    private var tagDetails: TagDetails?
    weak var delegate: TagDetailsViewModelDelegate?

    init(tagName: TagName, tagsActions: TagsActions) {
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