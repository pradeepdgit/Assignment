//
//  UIView+Extensions.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 17/07/24.
//

import UIKit

extension UIView {
    
    func toEdges(_ offset: CGFloat = 0.0) {
        toEdges(offset, offset, offset, offset)
    }
    
    func toEdges(_ left: CGFloat,_ top: CGFloat,_ right: CGFloat,_ bottom: CGFloat) {
        
        guard let superview = superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
    }
}
