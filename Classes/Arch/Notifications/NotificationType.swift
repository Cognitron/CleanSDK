//
//  NotificationType.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

public protocol NotificationType {
    
}

public extension NotificationType {
    var notificationName: Notification.Name {
        return Notification.Name(String(describing: self).replacingOccurrences(of: ".", with: "_"))
    }
}
