//
//  NotificationCell.swift
//  Paycell
//
//  Created by Ebru Bircan on 17.02.2026.
//


import UIKit

final class NotificationCell: UITableViewCell {

    static let reuseId = "NotificationCell"

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

    private lazy var iconContainer: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.12)
        v.layer.cornerRadius = 14
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "bell.badge.fill"))
        iv.tintColor = .systemBlue
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var messageLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .semibold)
        l.textColor = .label
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.setContentHuggingPriority(.defaultLow, for: .horizontal)
        l.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var datePill: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray.withAlphaComponent(0.14)
        v.layer.cornerRadius = 12
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setContentHuggingPriority(.required, for: .horizontal)
        v.setContentCompressionResistancePriority(.required, for: .horizontal)
        return v
    }()

    private lazy var dateStack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [dateIconView, dateLabel])
        s.axis = .horizontal
        s.alignment = .center
        s.spacing = 6
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()

    private lazy var dateIconView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "clock.fill"))
        iv.tintColor = .secondaryLabel
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var dateLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12, weight: .semibold)
        l.textColor = .secondaryLabel
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var chevronView: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "chevron.right"))
        iv.tintColor = .tertiaryLabel
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Setup
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)

        cardView.addSubview(iconContainer)
        iconContainer.addSubview(iconView)

        cardView.addSubview(datePill)
        datePill.addSubview(dateStack)

        cardView.addSubview(messageLabel)
        cardView.addSubview(chevronView)

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            iconContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            iconContainer.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 14),
            iconContainer.widthAnchor.constraint(equalToConstant: 44),
            iconContainer.heightAnchor.constraint(equalToConstant: 44),

            iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 22),
            iconView.heightAnchor.constraint(equalToConstant: 22),

            chevronView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),
            chevronView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 18),
            chevronView.widthAnchor.constraint(equalToConstant: 10),
            chevronView.heightAnchor.constraint(equalToConstant: 16),

            datePill.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            datePill.trailingAnchor.constraint(equalTo: chevronView.leadingAnchor, constant: -10),
            datePill.widthAnchor.constraint(lessThanOrEqualToConstant: 220),

            dateStack.topAnchor.constraint(equalTo: datePill.topAnchor, constant: 6),
            dateStack.bottomAnchor.constraint(equalTo: datePill.bottomAnchor, constant: -6),
            dateStack.leadingAnchor.constraint(equalTo: datePill.leadingAnchor, constant: 10),
            dateStack.trailingAnchor.constraint(equalTo: datePill.trailingAnchor, constant: -10),

            dateIconView.widthAnchor.constraint(equalToConstant: 14),
            dateIconView.heightAnchor.constraint(equalToConstant: 14),

            messageLabel.topAnchor.constraint(equalTo: iconContainer.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -14),
            messageLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -14),

            cardView.heightAnchor.constraint(greaterThanOrEqualToConstant: 92)
        ])
    }

    // MARK: - Configure
    func configure(with item: AppNotificationItem) {
        messageLabel.text = item.message
        dateLabel.text = item.dateText

        // Mesaja göre ufak renk/ikon varyasyonu (tamamen systemImage)
        if item.message.contains("+220") {
            iconContainer.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.14)
            iconView.image = UIImage(systemName: "checkmark.seal.fill")
            iconView.tintColor = .systemGreen
        } else if item.message.contains("+180") {
            iconContainer.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.14)
            iconView.image = UIImage(systemName: "sparkles")
            iconView.tintColor = .systemPurple
        } else if item.message.contains("+120") {
            iconContainer.backgroundColor = UIColor.systemOrange.withAlphaComponent(0.16)
            iconView.image = UIImage(systemName: "square.grid.2x2.fill")
            iconView.tintColor = .systemOrange
        } else {
            iconContainer.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.14)
            iconView.image = UIImage(systemName: "calendar.badge.checkmark")
            iconView.tintColor = .systemTeal
        }
    }
}

