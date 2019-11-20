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
        //todo: showError to the user
    }
}
