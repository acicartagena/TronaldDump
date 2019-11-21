//
//  UIViewController+Extensions.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

protocol ShowsError {
    func show(error: TronaldDumpError)
}

extension UIViewController: ShowsError {
    func show(error: TronaldDumpError) {
        let alert = UIAlertController(title: error.displayString, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
