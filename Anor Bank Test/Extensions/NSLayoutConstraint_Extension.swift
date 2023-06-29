//
//  NSLayoutConstraint_Extension.swift
//  Anor Bank Test
//
//  Created by Ismatilloxon Marudkhonov on 29/06/23.
//

import UIKit

extension UIView {
   
    func top(_ Anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.topAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func bottom(_ Anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.bottomAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func Y(_ Anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.centerYAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    
    func left(_ Anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.leftAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func leading(_ Anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.leadingAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func trailing(_ Anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.trailingAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func right(_ Anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.rightAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func X(_ Anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, _ Constraint: CGFloat = .zero) {
        self.centerXAnchor.constraint(equalTo: Anchor, constant: Constraint).isActive = true
    }
    
    func height(_ Constraint: CGFloat = 10) {
        self.heightAnchor.constraint(equalToConstant: Constraint).isActive = true
    }
    
    func width(_ Constraint: CGFloat = 10) {
        self.widthAnchor.constraint(equalToConstant: Constraint).isActive = true
    }
}
