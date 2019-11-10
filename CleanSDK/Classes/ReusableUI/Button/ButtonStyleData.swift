//
//  ButtonStyleData.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation

struct ButtonStyleData: Decodable {
    
    let backgroundColor: String?
    let borderColor: String?
    let textColor: String?

    let selectedBackgroundColor: String?
    let selectedBorderColor: String?
    let selectedTextColor: String?
    
    let highlightedBackgroundColor: String?
    let highlightedBorderColor: String?
    let highlightedTextColor: String?
    
    let disabledBackgroundColor: String?
    let disabledBorderColor: String?
    let disabledTextColor: String?
    
    let fontName: String?
    let fontSize: String?
    
    let topLeftRounded: Bool?
    let topRightRounded: Bool?
    let bottomLeftRounded: Bool?
    let bottomRightRounded: Bool?
    let cornerRadius: Float?
    
    let borderWidth: Float? 
    
}
