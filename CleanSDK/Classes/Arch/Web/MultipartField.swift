//
//  MultipartField.swift
//  Clean
//
//  Created by Artem Eremeev on 12/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

public enum MultipartField: CustomStringConvertible {
    case jpegImage(image: UIImage, imageName: String, field: String)
    case pngImage(image: UIImage, imageName: String, field: String)
    case value(value: Any, field: String)
    case file(fileData: Data, fileName: String, field: String)
    case fileReference(fileURL: URL, field: String)
    
    public var description: String {
        switch self {
        case let .jpegImage(_, imageName, field):
            return "JPEG image named \"\(imageName)\" for \"\(field)\""
        case let .pngImage(_, imageName, field):
            return "PNG image named \"\(imageName)\" for \"\(field)\""
        case let .value(value, field):
            return "\(value) for \"\(field)\""
        case let .file(_, fileName, field):
            return "File named \"\(fileName)\" for \"\(field)\""
        case let .fileReference(fileURL, field):
            return "File from \"\(fileURL)\" for \"\(field)\""
        }
    }
}
