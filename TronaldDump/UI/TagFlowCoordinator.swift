//  Copyright © 2019 ACartagena. All rights reserved.

import UIKit

protocol TagFlow: AnyObject {
    func gotoDetails(for tag: TagName)
    func gotoTagDetailsSource(url: URL)
}

class TagFlowCoordinator: TagFlow {
    let navigationController: UINavigationController
    private let service = TagService()

    init() {
        navigationController = UINavigationController()

        let viewModel = TagsViewModel(flow: self, actions: service)
        let viewController = TagsViewController(viewModel: viewModel)
        navigationController.viewControllers = [viewController]
    }

    func gotoDetails(for tag: TagName) {
        let viewModel = TagDetailsViewModel(tagName: tag, flow: self, actions: service)
        let viewController = TagDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    func gotoTagDetailsSource(url: URL) {
        UIApplication.shared.open(url)
    }
}
