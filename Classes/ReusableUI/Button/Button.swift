//
//  Button.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import UIKit

open class Button: UIButton {
    
    @IBInspectable var styleFileName: String? { didSet { loadStyle() } }
    @IBInspectable var bundleIdentifier: String? = Bundle.main.bundleIdentifier { didSet { loadStyle() } }
    
    private var reusableStyle: ButtonStyle! {
        didSet {
            setupTextColors(using: reusableStyle)
            setupFonts(using: reusableStyle)
            setNeedsDisplay()
        }
    }
    
    override open var isHighlighted: Bool { didSet { setNeedsDisplay() } }
    override open var isEnabled: Bool { didSet { setNeedsDisplay() } }
    override open var isSelected: Bool { didSet { setNeedsDisplay() } }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadStyle()
    }
    
    override open func draw(_ rect: CGRect) {
        
        guard let reusableStyle = self.reusableStyle else {
            return
        }
        
        if isEnabled {
            if isHighlighted {
                (reusableStyle.highlightedBackgroundColor ?? reusableStyle.backgroundColor)?.setFill()
                (reusableStyle.highlightedBorderColor ?? reusableStyle.borderColor)?.setStroke()
            } else {
                if isSelected {
                    (reusableStyle.selectedBackgroundColor ?? reusableStyle.backgroundColor)?.setFill()
                    (reusableStyle.selectedBorderColor ?? reusableStyle.borderColor)?.setStroke()
                } else {
                    reusableStyle.backgroundColor?.setFill()
                    reusableStyle.borderColor?.setStroke()
                }
            }
        } else {
            (reusableStyle.disabledBackgroundColor ?? reusableStyle.backgroundColor)?.setFill()
            (reusableStyle.disabledBorderColor ?? reusableStyle.borderColor)?.setStroke()
        }
        
        let frame = rect.insetBy(dx: reusableStyle.borderWidth, dy: reusableStyle.borderWidth)
        
        var corner: UIRectCorner = []
        if reusableStyle.topLeftRounded { corner = [corner, .topLeft] }
        if reusableStyle.topRightRounded { corner = [corner, .topRight] }
        if reusableStyle.bottomLeftRounded { corner = [corner, .bottomLeft] }
        if reusableStyle.bottomRightRounded { corner = [corner, .bottomRight] }
        
        let path = UIBezierPath(roundedRect: frame, byRoundingCorners: corner, cornerRadii: CGSize(width: reusableStyle.cornerRadius, height: reusableStyle.cornerRadius))
        path.lineWidth = reusableStyle.borderWidth
        path.fill()
        path.stroke()
        
    }
    
    private func loadStyle() {
        guard let styleFileName = self.styleFileName, let bundleIdentifier = self.bundleIdentifier else {
            return
        }
        reusableStyle = StyleDecoder.decodeStyle(bundleIdentifier: bundleIdentifier, styleFileName: styleFileName)
    }
    
    private func setupTextColors(using reusableStyle: ButtonStyle!) {
        guard let reusableStyle = reusableStyle else {
            return
        }
        setTitleColor(reusableStyle.textColor, for: .normal)
        setTitleColor(reusableStyle.selectedTextColor, for: .selected)
        setTitleColor(reusableStyle.highlightedTextColor, for: .highlighted)
        setTitleColor(reusableStyle.disabledTextColor, for: .disabled)
    }
    
    private func setupFonts(using reusableStyle: ButtonStyle!) {
        titleLabel?.font = reusableStyle?.font
    }

}


