//
//  StoryboardInstantiable.swift
//  TestAssignment
//
//  Created by Pradeepkumar on 2021-10-05.
//

import UIKit

public protocol StoryboardInstantiable: NSObjectProtocol {
    associatedtype T
    static var defaultFileName: String { get }
    static func instantiateViewController(_ storyBoardFileName: String, _ controllerIdentifier: String?, _ bundle: Bundle?) -> T
}

public extension StoryboardInstantiable where Self: UIViewController {

    static var defaultFileName: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last!
    }
    
    static func instantiateViewController(_ storyBoardFileName: String = "Main", _ controllerIdentifier: String? = defaultFileName, _ bundle: Bundle? = nil) -> Self {
        let storyboard = UIStoryboard(name: storyBoardFileName, bundle: bundle)
        guard let vc = storyboard.instantiateViewController(withIdentifier: controllerIdentifier!) as? Self else {
            
            fatalError("Cannot instantiate initial view controller \(Self.self) from storyboard with name \(controllerIdentifier ?? nil)")
        }
        return vc
    }
}
