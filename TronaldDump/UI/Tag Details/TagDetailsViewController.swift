//  Copyright © 2019 ACartagena. All rights reserved.

import UIKit

class TagDetailsViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self

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

extension TagDetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.itemsWithLoadingCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !viewModel.isLoading(for: indexPath) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        }

        let item = viewModel.items[indexPath.row]
        switch item {
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.reuseIdentifier) as! LoadingCell
            return cell
        case let .tagDetails(viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TagDetailsCell.reuseIdentifier) as! TagDetailsCell
            cell.setup(with: viewModel)
            return cell
        }
    }
}

extension TagDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectTag(at: indexPath.row)
    }
}

extension TagDetailsViewController: UITableViewDataSourcePrefetching {
    func tableView(_: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.first, viewModel.isLoading(for: indexPath) else { return }
        viewModel.loadNext()
    }
}

extension TagDetailsViewController: TagDetailsViewModelDelegate {
    func reload() {
        tableView.reloadData()
    }
}
