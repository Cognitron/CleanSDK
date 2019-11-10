//
//  ActivityConstructor.swift
//  Clean
//
//  Created by Artem Eremeev on 13/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public class ActivityConstructor: SystemActionConstructorType {
    
    private let activityController: UIActivityViewController
    
    public init(using items: [Any]) {
        activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    
    public func show() {
        present(controller: activityController)
    }
    
}
