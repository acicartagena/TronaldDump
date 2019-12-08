//  Copyright © 2019 ACartagena. All rights reserved.

import BrightFutures
import Foundation

protocol TagsViewModelDelegate: AnyObject, ShowsError {
    func reload()
}

class TagsViewModel {
    enum Item: Equatable {
        case loading
        case tag(TagName)
    }

    private weak var flow: TagFlow?
    private let actions: TagActions
    private let threadingModel: ThreadingModel
    private var context: ExecutionContext { return threadingModel() }

    private(set) var items: [Item] = []

    let title = NSLocalizedString("Tags", comment: "")
    weak var delegate: TagsViewModelDelegate?

    init(flow: TagFlow, actions: TagActions, threadingModel: @escaping ThreadingModel = DefaultThreadingModel) {
        self.flow = flow
        self.actions = actions
        self.threadingModel = threadingModel
        items = [.loading]
    }

    func start() {
        actions.getTags().onComplete(context) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case let .success(tags):
                strongSelf.items = tags.map { .tag($0) }
                strongSelf.delegate?.reload()
            case let .failure(error):
                strongSelf.delegate?.show(error: error)
            }
        }
    }

    func selected(tag: TagName) {
        flow?.gotoDetails(for: tag)
    }
}
