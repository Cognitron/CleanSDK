//
//  UIImage.swift
//  Clean
//
//  Created by Artem Eremeev on 28.10.2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    enum ImageFormat {
        case gif
        case jpg
        case png
        case webp
        case unknown
    }
    
    static func getFormat(forData data: Data) -> ImageFormat {
        
        let isStringContainsInString = { (source: String, value: String) -> Bool in
            return source.range(of: value, options: [String.CompareOptions.literal, .caseInsensitive, .diacriticInsensitive]) != nil 
        }
        
        let isAnyContainsInString = { (source: String, values: String...) -> Bool in
            return values.reduce(false, { (contains, nextValue) in return contains || isStringContainsInString(source, nextValue) })
        }
        
        guard let string = String(data: data, encoding: .isoLatin1) else {
            return .unknown
        }
        
        let prefix = String(string.prefix(30))
        
        if isStringContainsInString(prefix, "ÿØÿÛ") ||
           isAnyContainsInString(prefix, "ÿØÿà", "JFIF") ||
           isAnyContainsInString(prefix, "ÿØÿá", "Exif") {
            return .jpg
        }
        
        if isStringContainsInString(prefix, "PNG") {
            return .png
        }
        
        if isStringContainsInString(prefix, "GIF87a") ||
           isStringContainsInString(prefix, "GIF89a") {
            return .gif
        }
        
        if isAnyContainsInString(prefix, "RIFF", "WEBP") {
            return .webp
        }
        
        return .unknown
        
    }
    
}
