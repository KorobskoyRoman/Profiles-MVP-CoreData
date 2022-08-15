//
//  SearchView.swift
//  Profiles-MVP-CoreData
//
//  Created by Roman Korobskoy on 13.08.2022.
//

import UIKit

class SearchView: UIView {
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .mainBackground()
        tf.placeholder = TitleConstants.nameTFPlaceholder
        tf.setLeftPaddingPoints(Insets.inset10)
        tf.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        return tf
    }()
    let createButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Save", for: .normal)
        button.isEnabled = false
        return button
    }()
    private lazy var stackView = UIStackView(arrangedSubviews: [textField, createButton],
                                             axis: .vertical,
                                             spacing: Insets.inset10,
                                             distribution: .fillEqually)

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layoutIfNeeded()
        self.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        textField.layer.cornerRadius = self.frame.height / Insets.cornerMultiply
        createButton.layer.cornerRadius = self.frame.height / Insets.cornerMultiply
    }

    @objc private func textFieldDidChanged(_ textField: UITextField) {
        if textField.hasText {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
    }

    private func setConstraints() {
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Insets.inset10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Insets.inset10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Insets.inset10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Insets.inset10)
        ])
    }
}
