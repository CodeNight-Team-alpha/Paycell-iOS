//
//  NotificationsViewModel.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import Foundation

final class NotificationsViewModel {

    private let service: PaycellServiceProtocol
    private(set) var activeNotifications: [AppNotificationItem] = notifications


    init(service: PaycellServiceProtocol) {
        self.service = service
    }

}

/*
protocol NotificationsViewModelDelegate: AnyObject {
    func stateUpdated()
}

final class NotificationsViewModel {

    enum State {
        case idle
        case loading
        case loaded
        case error(String)
    }

    weak var delegate: NotificationsViewModelDelegate?

    private let service: PaycellServiceProtocol
    private var fetchTask: Task<Void, Never>?

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
                    // self.wordDetails = data
                    self.state = .loaded
                }
            } catch is CancellationError {
                // deinit sırasında iptal edilirse state değiştirmiyoruz
            } catch {
                await MainActor.run {
                    self.state = .error("Bir hata oluştu")
                }
            }
        }
    }
}
*/
