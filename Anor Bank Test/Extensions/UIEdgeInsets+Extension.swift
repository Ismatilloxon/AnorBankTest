//
//  UIEdge.swift
//  Anor Bank Test
//
//  Created by Ismatilla.adm on 25/06/23.
//

import UIKit

extension UIEdgeInsets {
    public static func all(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: margin,
            left: margin,
            bottom: margin,
            right: margin
        )
    }

    public init(all margin: CGFloat) {
        self = .all(margin)
    }

    public static func top(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: margin,
            left: .zero,
            bottom: .zero,
            right: .zero
        )
    }

    public init(top margin: CGFloat) {
        self = .top(margin)
    }

    public static func left(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: .zero,
            left: margin,
            bottom: .zero,
            right: .zero
        )
    }

    public init(left margin: CGFloat) {
        self = .left(margin)
    }

    public static func bottom(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: .zero,
            left: .zero,
            bottom: margin,
            right: .zero
        )
    }

    public init(bottom margin: CGFloat) {
        self = .bottom(margin)
    }

    public static func right(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: .zero,
            left: .zero,
            bottom: .zero,
            right: margin
        )
    }

    public init(right margin: CGFloat) {
        self = .right(margin)
    }

    public static func horizontal(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: .zero,
            left: margin,
            bottom: .zero,
            right: margin
        )
    }

    public init(horizontal margin: CGFloat) {
        self = .horizontal(margin)
    }

    public static func vertical(_ margin: CGFloat) -> UIEdgeInsets {
        self.init(
            top: margin,
            left: .zero,
            bottom: margin,
            right: .zero
        )
    }

    public init(vertical margin: CGFloat) {
        self = .vertical(margin)
    }

    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
}

extension UIView {
    /// Добавляет обработку нажатия и автоматически настраивает необходимые для этого параметры
    /// - Parameters:
    ///   - action: Хэндлер действия
    ///   - forceHandler: Если true, то экшн сработает сразу после нажатия, а не с задержкой от анимации (по-умолчанию
    /// false)
    /// - Returns: Гестур нажатия
    @discardableResult
    public func addTapHandler(
        _ action: @escaping () -> Void,
        forceHandler: Bool = false
    ) -> UITapGestureRecognizer {
        isUserInteractionEnabled = true
        tapGestureRecognizerAction = action
        tapForceHandler = forceHandler
        let tapGestureRecognizer: UITapGestureRecognizer
        if let recognizer = self.tapGestureRecognizer {
            tapGestureRecognizer = recognizer
        } else {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            addGestureRecognizer(recognizer)
            tapGestureRecognizer = recognizer
            self.tapGestureRecognizer = tapGestureRecognizer
        }
        return tapGestureRecognizer
    }

    @objc public func removeTapHandler() {
        tapGestureRecognizer.map(removeGestureRecognizer)
        tapGestureRecognizer = nil
        tapGestureRecognizerAction = nil
    }
}

extension UIView {
    private static let tapForceHandlerAssociation = ObjectAssociation<Bool>()
    private var tapForceHandler: Bool {
        get { UIView.tapForceHandlerAssociation[self] ?? false }
        set { UIView.tapForceHandlerAssociation[self] = newValue }
    }

    private static let tapGestureRecognizerAssociation = ObjectAssociation<UITapGestureRecognizer>()
    private var tapGestureRecognizer: UITapGestureRecognizer? {
        get { UIView.tapGestureRecognizerAssociation[self] }
        set { UIView.tapGestureRecognizerAssociation[self] = newValue }
    }

    private static let tapGestureRecognizerActionAssociation = ObjectAssociation<() -> Void>()
    private var tapGestureRecognizerAction: (() -> Void)? {
        get { UIView.tapGestureRecognizerActionAssociation[self] }
        set { UIView.tapGestureRecognizerActionAssociation[self] = newValue }
    }

    @objc private func handleTapGesture() {
        guard let action = tapGestureRecognizerAction else { return }
        action()
    }
}

public final class ObjectAssociation<T> {
    private let policy: objc_AssociationPolicy

    /// - Parameter policy: An association policy that will be used when linking objects.
    public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        self.policy = policy
    }

    /// Accesses associated object.
    /// - Parameter index: An object whose associated object is to be accessed.
    public subscript(index: AnyObject) -> T? {
        get { objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as? T }
        set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
    }
}
