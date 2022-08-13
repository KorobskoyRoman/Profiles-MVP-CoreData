//
//  UserCell.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import UIKit

final class UserCell: UITableViewCell {
    static let reuseId = "UserCell"
    private var name = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(from model: UserInfo) {
        self.name.text = model.name
    }

    private func setConstraints() {
        contentView.addSubview(name)
        contentView.subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            name.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Insets.inset10)
        ])
    }
}
