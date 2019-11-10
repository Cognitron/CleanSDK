//
//  StyleDecoder.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

class StyleDecoder {
    
    static func decodeStyle<D: Decodable, S: Style<D>>(bundleIdentifier: String = Bundle.main.bundleIdentifier ?? "", styleFileName: String) -> S? {
        guard let bundle = Bundle(identifier: bundleIdentifier) else {
            return nil
        }
        guard let path = bundle.path(forResource: styleFileName, ofType: "json") else {
            return nil
        }
        guard let data = NSData(contentsOfFile: path) else {
            return nil
        }
        let decoder = JSONDecoder()
        guard let styleData: D = try? decoder.decode(D.self, from: data as Data) else {
            return nil
        }
        let style = S(withData: styleData)
        return style
    }
    
}
