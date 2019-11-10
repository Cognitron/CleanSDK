//
//  StoryboardInstanceType.swift
//  Clean
//
//  Created by Artem Eremeev on 29/09/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardInstanceType {
    
    var name: String { get }
    var rootNavigationController: UINavigationController! { get }
    
}

public extension StoryboardInstanceType {
    
    func navigationController(controllerName: String) -> UINavigationController! {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let navigationController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "\(controllerName)NavigationController") as! UINavigationController
        return navigationController
    }
    
    var rootNavigationController: UINavigationController! {
        return navigationController(controllerName: name)
    }
    
}
