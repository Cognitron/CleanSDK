//
//  StyleableType.swift
//  CleanSDK
//
//  Created by Artem Eremeev on 13.11.2019.
//

import Foundation

public protocol StyleableType {
    
    var styleFileName: String? { get }
    var bundleIdentifier: String? { get }
    
}

extension StyleableType {

    func loadStyle<D:Decodable, S: Style<D>>() -> S! {
        guard let styleFileName = self.styleFileName, let bundleIdentifier = self.bundleIdentifier else {
            return nil
        }
        return StyleDecoder.decodeStyle(bundleIdentifier: bundleIdentifier, styleFileName: styleFileName)
    }
    
}
