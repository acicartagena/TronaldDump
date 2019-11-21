//
//  TagDetailsCell.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 21/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

struct TagDetailsCellViewModel {

    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.displayDateFormat
        return dateFormatter
    }()

    let date: String
    let quote: String
    let author: String

    init(tag: TagDetails.Details) {
        date = TagDetailsCellViewModel.dateFormatter.string(from: tag.appearedAt)
        quote = "\"\(tag.value)\""
        if let authorName = tag.author?.name {
            author = "- \(authorName)"
        } else {
            author = NSLocalizedString("- unknown", comment: "")
        }
    }
}

class TagDetailsCell: UITableViewCell {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().offset(CGFloat.margin)
        }

        contentView.addSubview(quoteLabel)
        quoteLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(CGFloat.margin)
            make.top.equalTo(dateLabel.snp.bottom).offset(CGFloat.between)
        }

        contentView.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().offset(CGFloat.margin)
            make.top.equalTo(quoteLabel.snp.bottom).offset(CGFloat.between)
            make.bottom.equalToSuperview().inset(CGFloat.margin)
        }
    }

    func setup(with viewModel: TagDetailsCellViewModel) {
        dateLabel.text = viewModel.date
        quoteLabel.text = viewModel.quote
        authorLabel.text = viewModel.author
    }
}