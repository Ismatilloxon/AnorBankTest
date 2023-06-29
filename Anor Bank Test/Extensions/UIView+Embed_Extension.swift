//
//  UIView+Embed_Extension.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

extension UIView {
    @discardableResult
    public func embed(into superview: UIView, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) -> Self {
        superview.addSubview(self)
        constraint(to: superview, margins: margins, style: style)
        return self
    }

    @discardableResult
    public func embed(
        into superview: UIView,
        constraintTo view: UIView,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle = .fill
    ) -> Self {
        superview.addSubview(self)
        constraint(to: view, margins: margins, style: style)
        return self
    }

    @discardableResult
    public func embed(
        into superview: UIView,
        constraintTo guide: UILayoutGuide,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle = .fill
    ) -> Self {
        superview.addSubview(self)
        constraint(to: guide, margins: margins, style: style)
        return self
    }
}

extension UIView {
    public enum EmbedStyle {
        /// Растягивает вью по всей ширине и высоте
        case fill
        /// Растягивает по ширине и приклеивает к верху вью
        case topFill
        /// Растягивает по ширине и приклеивает к низу вью
        case bottomFill
        /// Устанавливает вью в верхний правый угол
        case topRight
        /// Центрирует по горизонтали и приклеивает к низу вью
        case bottomCenter
        /// Растягивает по высоте и приклеивает к правой части вью
        case rightFill
        /// Растягивает по высоте и приклеивает к левой части вью
        case leftFill
        /// Центрирует на вью
        case center
        /// Растягивает по вертикали и центрирует по горизонтали
        case centerX
        /// Растягивает по горизонтали и центрирует по вертикали
        case centerY
        /// Приклеивает и центрирует к левому краю вью
        case left
        /// Приклеивает и центрирует к правому краю вью
        case right
    }

    func constraint(to view: UIView, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) {
        constraint(
            topAnchor: view.topAnchor,
            leftAnchor: view.leftAnchor,
            rightAnchor: view.rightAnchor,
            bottomAnchor: view.bottomAnchor,
            centerXAnchor: view.centerXAnchor,
            centerYAnchor: view.centerYAnchor,
            margins: margins,
            style: style
        )
    }

    func constraint(to guide: UILayoutGuide, margins: UIEdgeInsets = .zero, style: EmbedStyle = .fill) {
        constraint(
            topAnchor: guide.topAnchor,
            leftAnchor: guide.leftAnchor,
            rightAnchor: guide.rightAnchor,
            bottomAnchor: guide.bottomAnchor,
            centerXAnchor: guide.centerXAnchor,
            centerYAnchor: guide.centerYAnchor,
            margins: margins,
            style: style
        )
    }

    // swiftlint:disable function_body_length
    func constraint(
        topAnchor: NSLayoutYAxisAnchor,
        leftAnchor: NSLayoutXAxisAnchor,
        rightAnchor: NSLayoutXAxisAnchor,
        bottomAnchor: NSLayoutYAxisAnchor,
        centerXAnchor: NSLayoutXAxisAnchor,
        centerYAnchor: NSLayoutYAxisAnchor,
        margins: UIEdgeInsets = .zero,
        style: EmbedStyle
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []

        switch style {
        case .left, .fill, .topFill, .bottomFill, .leftFill, .centerY:
            constraints.append(
                self.leftAnchor.constraint(equalTo: leftAnchor, constant: margins.left)
            )
        case .center, .right, .bottomCenter, .centerX, .topRight:
            constraints.append(
                self.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor, constant: margins.left)
            )
        case .rightFill:
            break
        }

        switch style {
        case .right, .fill, .topFill, .bottomFill, .rightFill, .topRight, .centerY:
            constraints.append(
                self.rightAnchor.constraint(equalTo: rightAnchor, constant: -margins.right)
            )
        case .center, .left, .bottomCenter, .leftFill, .centerX:
            constraints.append(
                self.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor, constant: -margins.right)
            )
        }

        switch style {
        case .fill, .bottomFill, .rightFill, .bottomCenter, .leftFill, .centerX:
            constraints.append(
                self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margins.bottom)
            )
        case .right, .left, .center, .centerY, .topRight:
            constraints.append(
                self.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -margins.bottom)
            )
        case .topFill:
            break
        }

        switch style {
        case .fill, .topFill, .rightFill, .topRight, .leftFill, .centerX:
            constraints.append(
                self.topAnchor.constraint(equalTo: topAnchor, constant: margins.top)
            )
        case .right, .left, .center, .centerY:
            constraints.append(
                self.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: margins.top)
            )
        case .bottomFill, .bottomCenter:
            break
        }

        switch style {
        case .center, .left, .right, .centerY:
            constraints.append(
                self.centerYAnchor.constraint(equalTo: centerYAnchor)
            )
        case .fill, .topFill, .bottomFill, .rightFill, .bottomCenter, .topRight, .leftFill, .centerX:
            break
        }

        switch style {
        case .center, .bottomCenter, .centerX:
            constraints.append(
                self.centerXAnchor.constraint(equalTo: centerXAnchor)
            )
        case .fill, .topFill, .bottomFill, .left, .right, .rightFill, .topRight, .leftFill, .centerY:
            break
        }

        NSLayoutConstraint.activate(constraints)
    }
}
