//
//  UserInfoViewController.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import UIKit

final class UserInfoViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: UserInfoViewModel

    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private lazy var contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "User Metrics"
        l.font = .systemFont(ofSize: 28, weight: .bold)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var cardView: UIView = {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.12
        v.layer.shadowRadius = 14
        v.layer.shadowOffset = CGSize(width: 0, height: 8)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var headerStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, segmentBadgeView])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 10
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 22, weight: .semibold)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var segmentBadgeView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemBlue.withAlphaComponent(0.15)
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var segmentBadgeStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [segmentIconView, segmentLabel])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 6
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var segmentIconView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "person.fill"))
        iv.tintColor = .systemBlue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var segmentLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
        l.textColor = .systemBlue
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var metricsStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [
            spendTodayRow,
            uniqueCategoriesRow,
            electronicsSpendRow,
            spend7DaysRow
        ])
        s.axis = .vertical
        s.spacing = 12
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var spendTodayRow = MetricRowView(
        iconSystemName: "creditcard.fill",
        title: "Spend Today",
        tint: .systemGreen
    )

    private lazy var uniqueCategoriesRow = MetricRowView(
        iconSystemName: "square.grid.2x2.fill",
        title: "Unique Categories Today",
        tint: .systemOrange
    )

    private lazy var electronicsSpendRow = MetricRowView(
        iconSystemName: "tv.fill",
        title: "Electronics Spend Today",
        tint: .systemPurple
    )

    private lazy var spend7DaysRow = MetricRowView(
        iconSystemName: "calendar.badge.clock",
        title: "Spend 7 Days",
        tint: .systemTeal
    )

    // MARK: - Init
    init(viewModel: UserInfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyData()
    }

    private func setupUI() {
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(cardView)

        cardView.addSubview(headerStack)
        cardView.addSubview(metricsStack)
        segmentBadgeView.addSubview(segmentBadgeStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            cardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),

            headerStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            headerStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),

            segmentBadgeStack.topAnchor.constraint(equalTo: segmentBadgeView.topAnchor, constant: 6),
            segmentBadgeStack.bottomAnchor.constraint(equalTo: segmentBadgeView.bottomAnchor, constant: -6),
            segmentBadgeStack.leadingAnchor.constraint(equalTo: segmentBadgeView.leadingAnchor, constant: 10),
            segmentBadgeStack.trailingAnchor.constraint(equalTo: segmentBadgeView.trailingAnchor, constant: -10),

            metricsStack.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 16),
            metricsStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            metricsStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            metricsStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }

    private func applyData() {
        let data = viewModel.userInfo
        nameLabel.text = data.name
        segmentLabel.text = data.segment
        spendTodayRow.setValue("\(data.spendToday)")
        uniqueCategoriesRow.setValue("\(data.uniqueCategoriesToday)")
        electronicsSpendRow.setValue(String(format: "%.1f", data.electronicsSpendToday))
        spend7DaysRow.setValue("\(data.spendLast7Days)")
    }
}

private final class MetricRowView: UIView {

    private let tint: UIColor

    private lazy var container: UIView = {
        let v = UIView()
        v.backgroundColor = tint.withAlphaComponent(0.1)
        v.layer.cornerRadius = 14
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = tint
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.textColor = .secondaryLabel
        l.font = .systemFont(ofSize: 14)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .bold)
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    init(iconSystemName: String, title: String, tint: UIColor) {
        self.tint = tint
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        iconView.image = UIImage(systemName: iconSystemName)
        titleLabel.text = title

        addSubview(container)
        container.addSubview(iconView)
        container.addSubview(titleLabel)
        container.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),

            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            iconView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 18),
            iconView.heightAnchor.constraint(equalToConstant: 18),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            valueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),

            container.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setValue(_ text: String) {
        valueLabel.text = text
    }
}



/*
final class UserInfoViewController: UIViewController {

    // MARK: - Dependencies
    private let viewModel: UserInfoViewModel

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
    init(viewModel: UserInfoViewModel) {
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

extension UserInfoViewController: UserInfoViewModelDelegate {
    func stateUpdated() {
        render()
    }
}
*/
