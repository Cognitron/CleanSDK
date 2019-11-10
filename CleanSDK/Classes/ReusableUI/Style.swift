//
//  Style.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

class Style<D: Decodable> {
    
    let data: D
    
    required init(withData data: D) {
        self.data = data
    }
    
    func color(fromHexString hex: String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count < 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        if cString.count == 8 {
            return UIColor(red: CGFloat((rgbValue & 0xFF000000) >> 32) / 255,
                           green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255,
                           blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255,
                           alpha: CGFloat(rgbValue & 0x000000FF) / 255)
        } else {
            return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
                           green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
                           blue: CGFloat(rgbValue & 0x0000FF) / 255,
                           alpha: 1)
        }
    }
    
}
