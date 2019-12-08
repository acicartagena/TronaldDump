//  Copyright © 2019 ACartagena. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let coordinator = TagFlowCoordinator()

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
