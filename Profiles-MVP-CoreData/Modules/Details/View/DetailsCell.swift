//
//  DetailsCell.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import UIKit

final class DetailsCell: UITableViewCell {
    static let reuseId = "DetailsCell"
    private lazy var name: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .mainBackground()
        tf.placeholder = TitleConstants.nameTFPlaceholder
        tf.setLeftPaddingPoints(Insets.inset10)
        tf.addTarget(self, action: #selector(nameTf), for: .editingDidBegin)
        tf.isEnabled = false
        tf.textColor = .gray
        return tf
    }()
    private lazy var image = UIImageView()
    private lazy var date: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .mainBackground()
        tf.placeholder = TitleConstants.birthdayTFPlaceholder
        tf.setLeftPaddingPoints(Insets.inset10)
        tf.addTarget(self, action: #selector(nameTf), for: .editingDidBegin)
        tf.isEnabled = false
        tf.textColor = .gray
        return tf
    }()
    private lazy var gender: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .mainBackground()
        tf.placeholder = TitleConstants.genderTFPlaceholder
        tf.setLeftPaddingPoints(Insets.inset10)
        tf.addTarget(self, action: #selector(nameTf), for: .editingDidBegin)
        tf.isEnabled = false
        tf.textColor = .gray
        return tf
    }()
    private lazy var stackView = UIStackView(arrangedSubviews: [
        image,
        name,
        date,
        gender
    ],
                                             axis: .vertical,
                                             spacing: Insets.inset30,
                                             aligment: .fill,
                                             distribution: .fillEqually)
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerCurve = .continuous
        button.setTitle("Edit", for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.widthAnchor.constraint(equalToConstant: Insets.inset100).isActive = true
        button.tintColor = .gray
        button.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return button
    }()
    private var isEdit = false
    var presenter: DetailsPresenter = DetailsPresenter()
    var index: Int = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        name.layer.cornerRadius = Insets.inset10
        date.layer.cornerRadius = Insets.inset10
        gender.layer.cornerRadius = Insets.inset10
        editButton.layer.cornerRadius = Insets.inset10
    }

    func configure(from model: UserInfo) {
//        self.image =
        self.name.text = model.name
        self.date.text = model.birthday
        self.gender.text = model.gender
    }

    private func setConstraints() {
        contentView.addSubview(stackView)
        contentView.addSubview(editButton)
        contentView.subviews.forEach {$0.translatesAutoresizingMaskIntoConstraints = false}

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Insets.inset100),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Insets.inset30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Insets.inset30),

            name.heightAnchor.constraint(equalToConstant: Insets.inset50),
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: Insets.inset10),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Insets.inset10)
        ])
    }

    @objc private func nameTf(_ textField: UITextField) {
        textField.text = ""
    }

    func toggleEnable() {
        name.isEnabled.toggle()
        date.isEnabled.toggle()
        gender.isEnabled.toggle()
        name.textColor = .black
        date.textColor = .black
        gender.textColor = .black
    }

    @objc private func editButtonAction(_ sender: UIButton) {
        switch isEdit {
        case true:
            sender.setTitle("Edit", for: .normal)
            toggleEnable()
            presenter.editData(index: index,
                               name: name.text,
                               birthday: date.text,
                               gender: gender.text)
            isEdit = false
        case false:
            sender.setTitle("Done", for: .normal)
            toggleEnable()
            isEdit = true
        }
    }
}

