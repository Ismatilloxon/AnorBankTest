//
//  StackView.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marufkhonov on 24/06/23.
//

import UIKit

public enum StackViewOption {
    case arrangedSubviews([UIView])
    case spacing(CGFloat)
    case alignment(UIStackView.Alignment)
    case margins(UIEdgeInsets)
    case axis(NSLayoutConstraint.Axis)
    case distribution(UIStackView.Distribution)
}


public protocol StackViewOptionProtocol: UIView {
    var stack: UIStackView { get }
    func prepare(_ option: StackViewOption)
    @discardableResult
    func prepare(_ options: StackViewOption...) -> Self
}

extension StackViewOptionProtocol {
    public func prepare(_ option: StackViewOption) {
        switch option {
        case let .arrangedSubviews(arrangedSubviews):
            arrangedSubviews.forEach(stack.addArrangedSubview)
        case let .alignment(alignment):
            stack.alignment = alignment
        case let .axis(axis):
            stack.axis = axis
        case let .distribution(distribution):
            stack.distribution = distribution
        case let .margins(margins):
            stack.layoutMargins = margins
        case let .spacing(spacing):
            stack.spacing = spacing
        }
    }

    @discardableResult
    public func prepare(_ options: StackViewOption...) -> Self {
        options.forEach(prepare)
        return self
    }
}
