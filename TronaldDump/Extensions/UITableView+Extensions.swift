//
//  UITableView+Extensions.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T>(_ aClass: T.Type) where T: UITableViewCell {
        register(aClass, forCellReuseIdentifier: aClass.reuseIdentifier)
    }
}
