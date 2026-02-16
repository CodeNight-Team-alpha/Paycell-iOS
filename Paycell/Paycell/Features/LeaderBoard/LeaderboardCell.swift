//
//  LeaderboardCell.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import UIKit

final class LeaderboardCell: UITableViewCell {

    static let reuseId = "LeaderboardCell"

    // MARK: - UI
    private lazy var cardView: UIView = {
        let v = UIView()
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 16
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.06
        v.layer.shadowRadius = 12
        v.layer.shadowOffset = CGSize(width: 0, height: 6)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var rankPill: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray.withAlphaComponent(0.14)
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setContentHuggingPriority(.required, for: .horizontal)
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        return v
    }()

    private lazy var rankLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .bold)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var trophyContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 14
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var trophyImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "trophy.fill"))
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .label
        l.numberOfLines = 1
        l.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var badgeLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, badgeLabel])
        s.axis = .vertical
        s.spacing = 4
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var pointsPill: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray.withAlphaComponent(0.12)
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setContentHuggingPriority(.required, for: .horizontal)
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        return v
    }()

    private lazy var pointsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .bold)
        l.textColor = .label
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var chevronView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .tertiaryLabel
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)

        cardView.addSubview(rankPill)
        rankPill.addSubview(rankLabel)

        cardView.addSubview(trophyContainer)
        trophyContainer.addSubview(trophyImageView)

        cardView.addSubview(textStack)

        cardView.addSubview(pointsPill)
        pointsPill.addSubview(pointsLabel)

        cardView.addSubview(chevronView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 76),

            rankPill.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            rankPill.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),

            rankLabel.topAnchor.constraint(equalTo: rankPill.topAnchor, constant: 6),
            rankLabel.bottomAnchor.constraint(equalTo: rankPill.bottomAnchor, constant: -6),
            rankLabel.leadingAnchor.constraint(equalTo: rankPill.leadingAnchor, constant: 10),
            rankLabel.trailingAnchor.constraint(equalTo: rankPill.trailingAnchor, constant: -10),

            trophyContainer.leadingAnchor.constraint(equalTo: rankPill.trailingAnchor, constant: 10),
            trophyContainer.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            trophyContainer.widthAnchor.constraint(equalToConstant: 44),
            trophyContainer.heightAnchor.constraint(equalToConstant: 44),

            trophyImageView.centerXAnchor.constraint(equalTo: trophyContainer.centerXAnchor),
            trophyImageView.centerYAnchor.constraint(equalTo: trophyContainer.centerYAnchor),
            trophyImageView.widthAnchor.constraint(equalToConstant: 22),
            trophyImageView.heightAnchor.constraint(equalToConstant: 22),

            chevronView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),
            chevronView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 10),
            chevronView.heightAnchor.constraint(equalToConstant: 16),

            pointsPill.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -10),
            pointsPill.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            pointsPill.widthAnchor.constraint(greaterThanOrEqualToConstant: 72),

            pointsLabel.topAnchor.constraint(equalTo: pointsPill.topAnchor, constant: 6),
            pointsLabel.bottomAnchor.constraint(equalTo: pointsPill.bottomAnchor, constant: -6),
            pointsLabel.leadingAnchor.constraint(equalTo: pointsPill.leadingAnchor, constant: 10),
            pointsLabel.trailingAnchor.constraint(equalTo: pointsPill.trailingAnchor, constant: -10),

            textStack.leadingAnchor.constraint(equalTo: trophyContainer.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: pointsPill.leadingAnchor, constant: -10),
            textStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
        ])
    }

    func configure(with item: LeaderboardItem, rank: Int) {
        rankLabel.text = "#\(rank)"
        nameLabel.text = item.name
        badgeLabel.text = item.badgeName
        pointsLabel.text = "\(item.points) pts"

        let (tint, bg) = badgeTheme(for: item.badgeName)
        trophyImageView.tintColor = tint
        trophyContainer.backgroundColor = bg
    }

    private func badgeTheme(for badge: String) -> (UIColor, UIColor) {
        let lower = badge.lowercased()
        if lower.contains("gold") {
            return (.systemYellow, UIColor.systemYellow.withAlphaComponent(0.14))
        } else if lower.contains("silver") {
            return (.systemGray, UIColor.systemGray.withAlphaComponent(0.16))
        } else {
            return (.systemBrown, UIColor.systemBrown.withAlphaComponent(0.14))
        }
    }
}
