//
//  UserInfoViewModel.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

final class UserInfoViewModel {

    private let service: PaycellServiceProtocol
    private(set) var userInfo: UserSpendSummary = userSample


    init(service: PaycellServiceProtocol) {
        self.service = service
    }

}

/*
protocol UserInfoViewModelDelegate: AnyObject {
    func stateUpdated()
}

final class UserInfoViewModel {

    enum State {
        case idle
        case loading
        case loaded
        case error(String)
    }

    weak var delegate: UserInfoViewModelDelegate?

    private let service: PaycellServiceProtocol
    private var fetchTask: Task<Void, Never>?
    private(set) var userInfo: UserSpendSummary = userSample

    private(set) var state: State = .idle {
        didSet { delegate?.stateUpdated() }
    }

    init(service: PaycellServiceProtocol) {
        self.service = service
    }

    deinit {
        fetchTask?.cancel()
    }

    func fetch(word: String) {
        state = .loading

        fetchTask = Task { [weak self] in
            guard let self else { return }

            do {
                // let data = try await service.fetchWordDetail(word)

                try Task.checkCancellation()

                await MainActor.run {
                    self.state = .loaded
                }
            } catch is CancellationError {
                
            } catch {
                await MainActor.run {
                    self.state = .error("Bir hata oluştu")
                }
            }
        }
    }
}

*/
