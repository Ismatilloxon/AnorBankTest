//
//  UIApplication_Extension.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate

extension UIApplication {
    public var mainKeyWindow: UIWindow? {
        connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first(where: \.isKeyWindow)
    }

    public var currentScene: UIWindowScene? {
        connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }

    public static var topViewController: UIViewController? {
        getTopViewController()
    }

    public static func getTopViewController(
        rootViewController: UIViewController? = UIApplication.shared.mainKeyWindow?.rootViewController
    ) -> UIViewController? {
        switch rootViewController {
        case let navigationController as UINavigationController:
            return getTopViewController(rootViewController: navigationController.visibleViewController)

        case let tabBarController as UITabBarController:
            guard let selectedViewController = tabBarController.selectedViewController else { fallthrough }
            return getTopViewController(rootViewController: selectedViewController)

        default:
            guard
                let presentedViewController = rootViewController?.presentedViewController
            else { return rootViewController }
            return getTopViewController(rootViewController: presentedViewController)
        }
    }

    public var safeAreaInsets: UIEdgeInsets {
        UIApplication.shared.mainKeyWindow?.safeAreaInsets ?? .zero
    }

    public func changeUserInterfaceStyle(_ userInterfaceStyle: UIUserInterfaceStyle) {
        for window in windows {
            window.overrideUserInterfaceStyle = userInterfaceStyle
        }
    }
}
