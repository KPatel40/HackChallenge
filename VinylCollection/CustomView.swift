//
//  SceneDelegate.swift
//  VinylCollection
//
//  Created by Krishna Patel
//

import UIKit

class CustomView: UITableViewCell {
    private let nameLabel = UILabel()
    private let artistLabel = UILabel()
    private let yearLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = .black
        contentView.addSubview(nameLabel)

        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.font = .systemFont(ofSize: 16)
        artistLabel.textColor = .darkGray
        contentView.addSubview(artistLabel)

        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = .systemFont(ofSize: 16)
        yearLabel.textColor = .darkGray
        contentView.addSubview(yearLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            artistLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            artistLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

            yearLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 5),
            yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            yearLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            yearLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configure(with vinyl: VinylData) {
        nameLabel.text = vinyl.name
        artistLabel.text = vinyl.artist
        yearLabel.text = vinyl.year
    }
}
