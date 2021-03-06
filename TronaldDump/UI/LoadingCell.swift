//  Copyright © 2019 ACartagena. All rights reserved.

import SnapKit
import UIKit

class LoadingCell: UITableViewCell {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        activityIndicator.startAnimating()
    }

    private func setupUI() {
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(CGFloat.margin)
        }
    }
}
