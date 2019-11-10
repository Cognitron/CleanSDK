//
//  Debugger.swift
//  Clean
//
//  Created by Artem Eremeev on 13/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public class Debugger {
    
    static private(set) var localization = false
    static private(set) var notifier = false
    static private(set) var navigator = false
    
    static private(set) var needDebugWebRoute = false
    static private(set) var needDebugWebParameters = false
    static private(set) var needDebugWebHeaders = false
    static private(set) var needDebugWebResponse = false
    
    static private(set) var ui = false
    static private(set) var fileManager = false
    
    public static func configure(_ units: [DebuggerUnit]) {
        
        localization = false
        notifier = false
        navigator = false
        
        needDebugWebRoute = false
        needDebugWebParameters = false
        needDebugWebHeaders = false
        needDebugWebResponse = false
        
        ui = false
        fileManager = false 
        
        for unit in units {
            switch unit {
            case .localization: localization = true
            case .notifier: notifier = true
            case .navigator: navigator = true
                
            case let .web(options):
                for option in options {
                    switch option {
                    case .route: needDebugWebRoute = true
                    case .parameters: needDebugWebParameters = true
                    case .headers: needDebugWebHeaders = true
                    case .response: needDebugWebResponse = true
                    }
                }
                
            case .ui: ui = true
            case .fileManager: fileManager = true
            }
        }
        
    }
    
}
