//
//  MainTabBarController.swift
//  Paycell
//
//  Created by Ebru Bircan on 16.02.2026.
//

import UIKit

final class MainTabBarController: UITabBarController {

    private let paycellService: PaycellServiceProtocol

    init(paycellService: PaycellServiceProtocol) {
        self.paycellService = paycellService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        // 1) User
        let userVM = UserInfoViewModel(service: paycellService)
        let userVC = UserInfoViewController(viewModel: userVM)
        let userNav = UINavigationController(rootViewController: userVC)
        userNav.tabBarItem = UITabBarItem(title: "User", image: UIImage(systemName: "person"), tag: 0)

        // 2) Leaderboard
        let leaderboardVM = LeaderboardViewModel(service: paycellService)
        let leaderboardVC = LeaderboardViewController(viewModel: leaderboardVM)
        let leaderboardNav = UINavigationController(rootViewController: leaderboardVC)
        leaderboardNav.tabBarItem = UITabBarItem(title: "Board", image: UIImage(systemName: "list.number"), tag: 1)

        // 3) Challenges
        let challengesVM = ChallengesViewModel(service: paycellService)
        let challengesVC = ChallengesViewController(viewModel: challengesVM)
        let challengesNav = UINavigationController(rootViewController: challengesVC)
        challengesNav.tabBarItem = UITabBarItem(title: "Challenges", image: UIImage(systemName: "flag"), tag: 2)

        // 4) Notifications
        let notificationsVM = NotificationsViewModel(service: paycellService)
        let notificationsVC = NotificationsViewController(viewModel: notificationsVM)
        let notificationsNav = UINavigationController(rootViewController: notificationsVC)
        notificationsNav.tabBarItem = UITabBarItem(title: "Notifs", image: UIImage(systemName: "bell"), tag: 3)

        viewControllers = [userNav, leaderboardNav, challengesNav, notificationsNav]
        selectedIndex = 0
    }
}

