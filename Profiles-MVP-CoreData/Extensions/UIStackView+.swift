//
//  UIStackView+.swift
//  SSoftProject
//
//  Created by Roman Korobskoy on 19.07.2022.
//

import UIKit

extension UIStackView {

    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat,
                     aligment: UIStackView.Alignment = .fill,
                     distribution: UIStackView.Distribution = .fill) {

        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = aligment
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
        self.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
