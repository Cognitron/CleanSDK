//
//  Notifier.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import RxSwift

public class Notifier {
    
    public static func post(object: Any, for notification: NotificationType) {
        NotificationCenter.default.post(name: notification.notificationName, object: nil, userInfo: ["value": object])
    }
    
    public static func post(notification: NotificationType) {
        NotificationCenter.default.post(name: notification.notificationName, object: nil)
    }
    
    public static func observe<T>(notification: NotificationType) -> Observable<T> {
        return NotificationCenter.default.rx.notification(notification.notificationName).map({ notification in
            return notification.userInfo!["value"] as! T
        })
    }
    
    public static func observe(notification: NotificationType) -> Observable<Void> {
        return NotificationCenter.default.rx.notification(notification.notificationName).map({ _ in })
    }
    
}
