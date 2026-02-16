//
//  ChallengeCell.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//

import UIKit

final class ChallengeCell: UITableViewCell {

    static let reuseId = "ChallengeCell"

    private lazy var cardView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 16
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.06
        v.layer.shadowRadius = 12
        v.layer.shadowOffset = CGSize(width: 0, height: 6)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var iconContainer: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 14
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // 🔥 FIX: 2 satır + wrapping + compression ayarları
    private lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        l.textColor = .label
        l.numberOfLines = 2
        l.lineBreakMode = .byWordWrapping
        l.setContentHuggingPriority(.defaultLow, for: .horizontal)
        l.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var pointsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var textStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [nameLabel, pointsLabel])
        s.axis = .vertical
        s.spacing = 4
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var statusPill: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setContentHuggingPriority(.required, for: .horizontal)
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        return v
    }()

    private lazy var statusStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [statusIconView, statusLabel])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 6
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var statusIconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var statusLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13, weight: .semibold)
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
        cardView.addSubview(iconContainer)
        iconContainer.addSubview(iconView)
        cardView.addSubview(textStack)
        cardView.addSubview(statusPill)
        statusPill.addSubview(statusStack)
        cardView.addSubview(chevronView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            iconContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            iconContainer.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 44),
            iconContainer.heightAnchor.constraint(equalToConstant: 44),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            textStack.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
            textStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            textStack.trailingAnchor.constraint(lessThanOrEqualTo: statusPill.leadingAnchor, constant: -12),

            statusPill.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            statusPill.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -10),
            statusPill.widthAnchor.constraint(lessThanOrEqualToConstant: 120), // 🔥 FIX

            statusStack.topAnchor.constraint(equalTo: statusPill.topAnchor, constant: 6),
            statusStack.bottomAnchor.constraint(equalTo: statusPill.bottomAnchor, constant: -6),
            statusStack.leadingAnchor.constraint(equalTo: statusPill.leadingAnchor, constant: 10),
            statusStack.trailingAnchor.constraint(equalTo: statusPill.trailingAnchor, constant: -10),

            statusIconView.widthAnchor.constraint(equalToConstant: 14),
            statusIconView.heightAnchor.constraint(equalToConstant: 14),

            chevronView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),
            chevronView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            chevronView.widthAnchor.constraint(equalToConstant: 10),
            chevronView.heightAnchor.constraint(equalToConstant: 16),

            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 84) // 🔥 FIX
        ])
    }

    func configure(with item: ChallengeItem) {
        nameLabel.text = item.challengeName
        pointsLabel.text = "\(item.rewardPoints) pts"

        let iconName: String
        if item.challengeName.contains("Elektronik") {
            iconName = "tv.fill"
        } else if item.challengeName.contains("Kategori") {
            iconName = "square.grid.2x2.fill"
        } else if item.challengeName.contains("Günlük") {
            iconName = "calendar"
        } else {
            iconName = "flame.fill"
        }
        iconView.image = UIImage(systemName: iconName)

        if item.isCompleted {
            cardView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.12)
            iconContainer.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.18)
            iconView.tintColor = .systemGreen

            statusPill.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.18)
            statusIconView.image = UIImage(systemName: "checkmark.seal.fill")
            statusIconView.tintColor = .systemGreen
            statusLabel.text = "Alındı"
            statusLabel.textColor = .systemGreen
        } else {
            cardView.backgroundColor = .secondarySystemBackground
            iconContainer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
            iconView.tintColor = .systemBlue

            statusPill.backgroundColor = UIColor.systemGray.withAlphaComponent(0.18)
            statusIconView.image = UIImage(systemName: "clock.fill")
            statusIconView.tintColor = .secondaryLabel
            statusLabel.text = "Alınmadı"
            statusLabel.textColor = .secondaryLabel
        }
    }
}
