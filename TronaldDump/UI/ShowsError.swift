//  Copyright © 2019 ACartagena. All rights reserved.

import UIKit

protocol ShowsError {
    func show(error: TronaldDumpError)
}

extension UIViewController: ShowsError {
    func show(error: TronaldDumpError) {
        let alert = UIAlertController(title: error.displayString, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
