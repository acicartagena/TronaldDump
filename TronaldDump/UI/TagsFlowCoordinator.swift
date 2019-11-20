//
//  AppCoordinator.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

protocol TagsFlow: AnyObject {
    func gotoDetails(for tag: TagName)
}

class TagsFlowCoordinator: TagsFlow {
    let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()

        let viewModel = TagsViewModel(flow: self, actions: TagsService())
        let viewController = TagsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }

    func gotoDetails(for tag: TagName) {
        let viewModel = TagDetailsViewModel(tagName: tag, tagsActions: TagsService())
        let viewController = TagDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
