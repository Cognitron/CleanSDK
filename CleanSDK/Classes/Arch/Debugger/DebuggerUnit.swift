//
//  DebuggerUnit.swift
//  Clean
//
//  Created by Artem Eremeev on 29.10.2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public enum DebuggerUnit {
    
    case localization
    case notifier
    case navigator
    case web(options: [WebDebuggerOptions])
    case ui
    case fileManager
    
}
