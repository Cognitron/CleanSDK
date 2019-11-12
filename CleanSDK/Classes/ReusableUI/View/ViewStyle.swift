//
//  ViewStyle.swift
//  CleanSDK
//
//  Created by Artem Eremeev on 13.11.2019.
//

import Foundation
import UIKit

class ViewStyle: Style<ViewStyleData> {
    
    lazy var cornerRadius = CGFloat(self.data.cornerRadius ?? 0.0)

    lazy var backgroundColor = self.optionalColor(fromHexString: self.data.backgroundColor ?? "")
    lazy var borderColor = self.optionalColor(fromHexString: self.data.borderColor ?? "")
    lazy var borderWidth = CGFloat(self.data.borderWidth ?? 0.0)
    
    lazy var shadowRadius = CGFloat(self.data.shadowRadius ?? 0.0)
    lazy var shadowOffset: CGSize = {
        let width = CGFloat(self.data.shadowOffsetX ?? 0.0)
        let height = CGFloat(self.data.shadowOffsetY ?? 0.0)
        return CGSize(width: width, height: height)
    }()
    lazy var shadowColor = self.optionalColor(fromHexString: self.data.shadowColor ?? "")
    
}
