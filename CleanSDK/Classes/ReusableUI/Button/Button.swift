//
//  Button.swift
//  Clean
//
//  Created by Artem Eremeev on 24/10/2019.
//  Copyright © 2019 Artem Eremeev. All rights reserved.
//

import UIKit

@IBDesignable
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadStyle()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadStyle()
    }
    
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
                (reusableStyle.highlightedBackgroundColor ?? reusableStyle.backgroundColor?.withAlphaComponent(0.85))?.setFill()
                (reusableStyle.highlightedBorderColor ?? reusableStyle.borderColor?.withAlphaComponent(0.85))?.setStroke()
            } else {
                if isSelected {
                    (reusableStyle.selectedBackgroundColor ?? reusableStyle.backgroundColor?.withAlphaComponent(0.85))?.setFill()
                    (reusableStyle.selectedBorderColor ?? reusableStyle.borderColor?.withAlphaComponent(0.85))?.setStroke()
                } else {
                    reusableStyle.backgroundColor?.setFill()
                    reusableStyle.borderColor?.setStroke()
                }
            }
        } else {
            (reusableStyle.disabledBackgroundColor ?? reusableStyle.backgroundColor?.withAlphaComponent(0.5))?.setFill()
            (reusableStyle.disabledBorderColor ?? reusableStyle.borderColor?.withAlphaComponent(0.5))?.setStroke()
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
        setTitleColor(reusableStyle.highlightedTextColor  ?? reusableStyle.textColor?.withAlphaComponent(0.85), for: .highlighted)
        setTitleColor(reusableStyle.disabledTextColor ?? reusableStyle.textColor?.withAlphaComponent(0.5), for: .disabled)
    }
    
    private func setupFonts(using reusableStyle: ButtonStyle!) {
        titleLabel?.font = reusableStyle?.font
    }

}


