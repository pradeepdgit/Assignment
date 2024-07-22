//
//  UITableView+Extension.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-03.
//

import Foundation
import UIKit

extension UITableView {
    
    // Register a UITableViewCell using its class name as the identifier
    func register<T: UITableViewCell>(_: T.Type) {
        let className = String(describing: T.self)
        register(T.self, forCellReuseIdentifier: className)
    }
    
    // Register a UITableViewCell using a nib file
    func registerNib<T: UITableViewCell>(_: T.Type) {
        let className = String(describing: T.self)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
    
    // Dequeue a reusable UITableViewCell
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(className)")
        }
        return cell
    }
}
