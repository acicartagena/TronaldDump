//
//  AppCoordinator.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

protocol TagFlow: AnyObject {
    func gotoDetails(for tag: TagName)
    func gotoTagDetailsSource(url: URL)
}

class TagFlowCoordinator: TagFlow {
    let navigationController: UINavigationController

    init() {
        navigationController = UINavigationController()

        let viewModel = TagsViewModel(flow: self, actions: TagService())
        let viewController = TagsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }

    func gotoDetails(for tag: TagName) {
        let viewModel = TagDetailsViewModel(tagName: tag, flow: self, actions: TagService())
        let viewController = TagDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func gotoTagDetailsSource(url: URL) {
        UIApplication.shared.open(url)
    }
}
