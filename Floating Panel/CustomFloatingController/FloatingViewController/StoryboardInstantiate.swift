//
//  StoryboardInstantiate.swift
//  FloatingViewController
//
//  Created by yusuf demirkoparan on 4.10.2021.
//

import Foundation
import UIKit

enum StoryboardType: String {
   case Main
    
}

protocol StoryboardInstantiate {
    static var storyboardType: StoryboardType { get }
    static var storyboardIdentifier: String? { get }
    static var bundle: Bundle? { get }
}


extension StoryboardInstantiate {
    
    static var storyboardIdentifier: String? { String(describing: self) }
    static var bundle: Bundle? { return nil }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: bundle)
        if let strongIdentifier = storyboardIdentifier {
            return (storyboard.instantiateViewController(withIdentifier: strongIdentifier) as? Self)!
        }
        return (storyboard.instantiateInitialViewController() as? Self)!
    }
}
