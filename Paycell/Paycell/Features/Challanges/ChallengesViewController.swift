//
//  ChallangesViewController.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import UIKit

final class ChallengesViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: ChallengesViewModel

    // MARK: - UI
    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Challenges"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var subtitleLabel: UILabel = {
        let l = UILabel()
        l.text = "Complete challenges and collect reward points"
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .secondaryLabel
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = 72
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(ChallengeCell.self, forCellReuseIdentifier: ChallengeCell.reuseId)
        return tv
    }()

    // MARK: - Init
    init(viewModel: ChallengesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            tableView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource
extension ChallengesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.activeChallenges.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChallengeCell.reuseId,
            for: indexPath
        ) as? ChallengeCell else {
            return UITableViewCell()
        }

        cell.configure(with: viewModel.activeChallenges[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChallengesViewController: UITableViewDelegate {
    // Şimdilik boş. İstersen "tap olunca detay" vs ekleriz.
}

// MARK: - Cell


/*
final class ChallengesViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: ChallengesViewModel

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
    init(viewModel: ChallengesViewModel) {
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

extension ChallengesViewController: ChallengesViewModelDelegate {
    func stateUpdated() {
        render()
    }
}
*/
