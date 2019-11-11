//
//  ButtonStyle.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import Foundation
import UIKit

class ButtonStyle: Style<ButtonStyleData> {
    
    lazy var backgroundColor: UIColor? = self.optionalColor(fromHexString: self.data.backgroundColor ?? "")
    lazy var borderColor: UIColor? = self.optionalColor(fromHexString: self.data.borderColor ?? "")
    lazy var textColor: UIColor? = self.optionalColor(fromHexString: self.data.textColor ?? "")
    
    lazy var selectedBackgroundColor: UIColor? = self.optionalColor(fromHexString: self.data.selectedBackgroundColor ?? "")
    lazy var selectedBorderColor: UIColor? = self.optionalColor(fromHexString: self.data.selectedBorderColor ?? "")
    lazy var selectedTextColor: UIColor? = self.optionalColor(fromHexString: self.data.selectedTextColor ?? "")
    
    lazy var highlightedBackgroundColor: UIColor? = self.optionalColor(fromHexString: self.data.highlightedBackgroundColor ?? "")
    lazy var highlightedBorderColor: UIColor? = self.optionalColor(fromHexString: self.data.highlightedBorderColor ?? "")
    lazy var highlightedTextColor: UIColor? = self.optionalColor(fromHexString: self.data.highlightedTextColor ?? "")
    
    lazy var disabledBackgroundColor: UIColor? = self.optionalColor(fromHexString: self.data.disabledBackgroundColor ?? "")
    lazy var disabledBorderColor: UIColor? = self.optionalColor(fromHexString: self.data.disabledBorderColor ?? "")
    lazy var disabledTextColor: UIColor? = self.optionalColor(fromHexString: self.data.disabledTextColor ?? "")
    
    lazy var font: UIFont? = {
        let fontSize = CGFloat(Float(self.data.fontSize ?? "15") ?? 15)
        guard let fontName = self.data.fontName else {
            return UIFont.systemFont(ofSize: fontSize)
        }
        return UIFont(name: fontName, size: fontSize)
    }()
    
    lazy var topLeftRounded: Bool = self.data.topLeftRounded ?? true
    lazy var topRightRounded: Bool = self.data.topRightRounded ?? true
    lazy var bottomLeftRounded: Bool = self.data.bottomLeftRounded ?? true
    lazy var bottomRightRounded: Bool = self.data.bottomRightRounded ?? true 
    lazy var cornerRadius: CGFloat = CGFloat(self.data.cornerRadius ?? 0.0)
    
    lazy var borderWidth: CGFloat = CGFloat(self.data.borderWidth ?? 0.0)
    
}
