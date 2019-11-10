//
//  ErrorHandlerType.swift
//  Clean
//
//  Created by Artem Eremeev on 11/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public protocol ErrorHandlerType {
    
    func catchErrorMessage(message: String)
    
}

public extension ErrorHandlerType {
    
    func hadnle(error: Error) {
        catchErrorMessage(message: error.localizedDescription)
    }
    
}
