//
//  LeaderboardViewController.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import UIKit

final class LeaderboardViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: LeaderboardViewModel

    // MARK: - Data
    private var topUser: LeaderboardItem? {
        viewModel.activeLeaderBoard.first
    }

    private var listItems: [LeaderboardItem] {
        Array(viewModel.activeLeaderBoard.dropFirst()) // rank 2+
    }

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .systemGroupedBackground
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 84
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(LeaderboardCell.self, forCellReuseIdentifier: LeaderboardCell.reuseId)
        return tv
    }()

    // tableHeaderView container
    private lazy var headerContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()

    private lazy var headerContentView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var myRankTitleLabel: UILabel = {
        let l = UILabel()
        l.text = "My Rank"
        l.font = .systemFont(ofSize: 14, weight: .semibold)
        l.textColor = .secondaryLabel
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var heroCircleView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear // ✅ boş arka
        v.layer.cornerRadius = 80
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.systemYellow.withAlphaComponent(0.55).cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var trophyImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "trophy.fill"))
        iv.tintColor = .systemYellow
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var rankValueLabel: UILabel = {
        let l = UILabel()
        l.text = "#1" // ✅ benmişim gibi sabit 1
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.textColor = .secondaryLabel
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var heroNameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .semibold)
        l.textColor = .label
        l.numberOfLines = 1
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var heroPointsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .bold)
        l.textColor = .label
        l.numberOfLines = 1
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var circleStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [
            trophyImageView,
            rankValueLabel,
            heroNameLabel,
            heroPointsLabel
        ])
        s.axis = .vertical
        s.alignment = .center
        s.spacing = 6
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var dividerView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.separator.withAlphaComponent(0.25)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var listHintLabel: UILabel = {
        let l = UILabel()
        l.text = "Leaderboard"
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .label
        l.textAlignment = .left
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Init
    init(viewModel: LeaderboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHeader()
        applyTopData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateHeaderSizeIfNeeded()
    }

    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupHeader() {
        headerContainerView.addSubview(headerContentView)

        headerContentView.addSubview(myRankTitleLabel)
        headerContentView.addSubview(heroCircleView)
        heroCircleView.addSubview(circleStack)

        headerContentView.addSubview(dividerView)
        headerContentView.addSubview(listHintLabel)

        NSLayoutConstraint.activate([
            headerContentView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerContentView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerContentView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerContentView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor),

            myRankTitleLabel.topAnchor.constraint(equalTo: headerContentView.topAnchor, constant: 18),
            myRankTitleLabel.leadingAnchor.constraint(equalTo: headerContentView.leadingAnchor, constant: 16),
            myRankTitleLabel.trailingAnchor.constraint(equalTo: headerContentView.trailingAnchor, constant: -16),

            heroCircleView.topAnchor.constraint(equalTo: myRankTitleLabel.bottomAnchor, constant: 10),
            heroCircleView.centerXAnchor.constraint(equalTo: headerContentView.centerXAnchor),
            heroCircleView.widthAnchor.constraint(equalToConstant: 160),
            heroCircleView.heightAnchor.constraint(equalToConstant: 160),

            circleStack.centerXAnchor.constraint(equalTo: heroCircleView.centerXAnchor),
            circleStack.centerYAnchor.constraint(equalTo: heroCircleView.centerYAnchor),

            trophyImageView.widthAnchor.constraint(equalToConstant: 28),
            trophyImageView.heightAnchor.constraint(equalToConstant: 28),

            dividerView.topAnchor.constraint(equalTo: heroCircleView.bottomAnchor, constant: 18),
            dividerView.leadingAnchor.constraint(equalTo: headerContentView.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: headerContentView.trailingAnchor, constant: -16),
            dividerView.heightAnchor.constraint(equalToConstant: 1),

            listHintLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 12),
            listHintLabel.leadingAnchor.constraint(equalTo: headerContentView.leadingAnchor, constant: 16),
            listHintLabel.trailingAnchor.constraint(equalTo: headerContentView.trailingAnchor, constant: -16),
            listHintLabel.bottomAnchor.constraint(equalTo: headerContentView.bottomAnchor, constant: -10),
        ])

        tableView.tableHeaderView = headerContainerView
        updateHeaderSizeIfNeeded()
    }

    private func updateHeaderSizeIfNeeded() {
        guard tableView.tableHeaderView === headerContainerView else { return }

        let targetWidth = tableView.bounds.width
        if headerContainerView.frame.width != targetWidth {
            headerContainerView.frame.size.width = targetWidth
        }

        headerContainerView.setNeedsLayout()
        headerContainerView.layoutIfNeeded()

        let size = headerContainerView.systemLayoutSizeFitting(
            CGSize(width: targetWidth, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        if headerContainerView.frame.height != size.height {
            headerContainerView.frame.size.height = size.height
            tableView.tableHeaderView = headerContainerView
        }
    }

    private func applyTopData() {
        guard let top = topUser else {
            heroNameLabel.text = "-"
            heroPointsLabel.text = "-"
            return
        }

        heroNameLabel.text = top.name
        heroPointsLabel.text = "\(top.points) pts"
    }
}

// MARK: - UITableViewDataSource
extension LeaderboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listItems.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LeaderboardCell.reuseId,
            for: indexPath
        ) as? LeaderboardCell else { return UITableViewCell() }

        let item = listItems[indexPath.row]
        let rank = indexPath.row + 2
        cell.configure(with: item, rank: rank)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeaderboardViewController: UITableViewDelegate { }





/*
final class LeaderboardViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: LeaderboardViewModel

    // MARK: - UI
    private lazy var loadingView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        v.isHidden = true
        v.isUserInteractionEnabled = true // ekrana dokunmayı da kilitler
        return v
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(style: .large)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.hidesWhenStopped = true
        return s
    }()

    // MARK: - Init
    init(viewModel: LeaderboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
        viewModel.fetch(word: "Hello")
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(loadingView)
        loadingView.addSubview(spinner)

        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            spinner.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }

    // MARK: - Render
    private func render() {
        switch viewModel.state {
        case .idle, .loaded:
            hideLoading()

        case .loading:
            showLoading()

        case .error(let msg):
            hideLoading()
            print(msg)
        }
    }

    private func showLoading() {
        loadingView.isHidden = false
        spinner.startAnimating()
    }

    private func hideLoading() {
        spinner.stopAnimating()
        loadingView.isHidden = true
    }
}

extension LeaderboardViewController: LeaderboardViewModelDelegate {
    func stateUpdated() {
        render()
    }
}
*/
