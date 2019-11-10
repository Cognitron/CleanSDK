//
//  SystemActionConstructorType.swift
//  Clean
//
//  Created by Artem Eremeev on 13/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public protocol SystemActionConstructorType {
    
}

public extension SystemActionConstructorType {
    
    var visibleController: UIViewController! {
        guard let delegate = UIApplication.shared.delegate, let window = delegate.window else {
            return nil
        }
        guard let visibleController = window?.visibleViewController() else {
            return nil
        }
        return visibleController
    }
    
    func present(controller: UIViewController) {
        DispatchQueue.main.async {
            self.visibleController?.present(controller, animated: true)
        }
    }
}
