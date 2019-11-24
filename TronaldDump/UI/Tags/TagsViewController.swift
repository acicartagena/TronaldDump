//
//  TagsViewController.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 19/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import BrightFutures
import SnapKit
import UIKit

class TagsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()

        tableView.register(TagCell.self)
        tableView.register(LoadingCell.self)

        return tableView
    }()

    private let viewModel: TagsViewModel

    init(viewModel: TagsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.start()
    }

    private func setupUI() {
        title = viewModel.title
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension TagsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        switch item {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        case let .tag(tagName):
            let cell = tableView.dequeueReusableCell(withIdentifier: TagCell.reuseIdentifier) as! TagCell
            cell.setup(with: tagName)
            return cell
        }
    }
}

extension TagsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard case let .tag(name) = viewModel.items[indexPath.row] else { return }
        viewModel.selected(tag: name)
    }
}

extension TagsViewController: TagsViewModelDelegate {
    func reload() {
        tableView.reloadData()
    }
}
