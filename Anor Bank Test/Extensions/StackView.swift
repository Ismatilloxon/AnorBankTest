//
//  StackView.swift
//  Anor Bank Test
//
//  Created by Ismatilla.adm on 24/06/23.
//

import UIKit

 class StackView: UIStackView, StackViewOptionProtocol {
    public var stack: UIStackView { self }

    public var margins: UIEdgeInsets {
        get { layoutMargins }
        set { layoutMargins = newValue }
    }

    public init(_ options: StackViewOption...) {
        super.init(frame: .zero)
        commonInit()
        options.forEach(prepare)
    }

    public init(
        arrangedSubviews: [UIView] = [],
        spacing: CGFloat = .zero,
        alignment: Alignment = .fill,
        margins: UIEdgeInsets = .zero,
        axis: NSLayoutConstraint.Axis = .vertical
    ) {
        super.init(frame: .zero)
        arrangedSubviews.forEach(addArrangedSubview)
        commonInit()
        self.spacing = spacing
        self.alignment = alignment
        self.margins = margins
        self.axis = axis
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    public required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

     func commonInit() {
        isLayoutMarginsRelativeArrangement = true
        insetsLayoutMarginsFromSafeArea = false
        axis = .vertical
        setupSubviews()
    }

     func setupSubviews() {
        // For override
    }
}

extension UIStackView {
    @discardableResult
    public func addArrangedSubviews(_ subviews: UIView...) -> Self {
        subviews.forEach(addArrangedSubview)
        return self
    }

    @discardableResult
    public func views(_ views: UIView...) -> Self {
        views.forEach(addArrangedSubview)
        return self
    }
}

