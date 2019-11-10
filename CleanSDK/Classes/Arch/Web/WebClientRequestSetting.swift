//
//  WebClientRequestSetting.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public enum WebClientRequestSetting {
    case queryParameters([String: Any])
    case jsonBody([String: Any])
    case form([String: Any])
    
    case headers([String: String])
    
    case basicAuth(user: String, password: String)
}
