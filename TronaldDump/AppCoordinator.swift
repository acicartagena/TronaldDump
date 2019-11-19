//
//  AppCoordinator.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import Foundation
import UIKit

class AppFlowCoordinator {
    let viewController: UIViewController

    init() {
        let viewController = TagsViewController()
        self.viewController = UINavigationController(rootViewController: viewController)

    }
}
