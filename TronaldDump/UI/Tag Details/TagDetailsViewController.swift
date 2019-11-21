//
//  TagDetailsViewController.swift
//  TronaldDump
//
//  Created by Angela Cartagena on 20/11/19.
//  Copyright © 2019 ACartagena. All rights reserved.
//

import UIKit

class TagDetailsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()

        tableView.register(TagDetailsCell.self)
        tableView.register(LoadingCell.self)

        return tableView
    }()

    let viewModel: TagDetailsViewModel
    
    init(viewModel: TagDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.start()
    }

    private func setupUI() {
        title = viewModel.tagName
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }

}

extension TagDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        switch item {
        case .loading:
            let cell =  tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        case .tagDetails(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TagDetailsCell.reuseIdentifier) as! TagDetailsCell
            cell.setup(with: viewModel)
            return cell
        }
    }
}

extension TagDetailsViewController: UITableViewDelegate {

}

extension TagDetailsViewController: TagDetailsViewModelDelegate {
    func reload() {
        tableView.reloadData()
    }
}
