//
//  ThenExtension.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

public protocol Then {}

extension Then where Self: Any {
    @discardableResult
    public func then(_ closure: (Self) throws -> Void) rethrows -> Self {
        try closure(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}
extension Array: Then {}
extension Dictionary: Then {}
extension Set: Then {}
extension JSONDecoder: Then {}
extension JSONEncoder: Then {}
extension UIEdgeInsets: Then {}
extension UIOffset: Then {}
extension UIRectEdge: Then {}

