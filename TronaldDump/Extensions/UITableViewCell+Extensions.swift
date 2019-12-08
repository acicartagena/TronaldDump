//  Copyright © 2019 ACartagena. All rights reserved.

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
