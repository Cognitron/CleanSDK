//
//  View.swift
//  Alamofire
//
//  Created by Artem Eremeev on 13.11.2019.
//

import UIKit

@IBDesignable
open class View: UIView, StyleableType {
    
    @IBInspectable public var styleFileName: String? { didSet { reloadStyle() } }
    @IBInspectable public var bundleIdentifier: String? = Bundle.main.bundleIdentifier { didSet { reloadStyle() } }
    
    private var reusableStyle: ViewStyle! {
        didSet {
            setupShadows(using: reusableStyle)
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        reloadStyle()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        reloadStyle()
    }
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        backgroundColor = .clear
        reloadStyle()
    }
    
    override open func draw(_ rect: CGRect) {
        
        guard let reusableStyle = self.reusableStyle else {
            return
        }
        
        let path = UIBezierPath(roundedRect: rect.insetBy(dx: reusableStyle.borderWidth, dy: reusableStyle.borderWidth), cornerRadius: reusableStyle.cornerRadius)
        path.lineWidth = reusableStyle.borderWidth
        
        (reusableStyle.backgroundColor ?? .clear).setFill()
        (reusableStyle.borderColor ?? .clear).setStroke()
        
        path.fill()
        path.stroke()
        
    }
    
    private func setupShadows(using reusableStyle: ViewStyle!) {
        guard let reusableStyle = reusableStyle else {
            return
        }
        if reusableStyle.shadowColor == .clear {
            layer.shadowOpacity = 0.0
        } else {
            layer.shadowOpacity = 1.0
            layer.shadowColor = reusableStyle.shadowColor?.cgColor
            layer.shadowRadius = reusableStyle.shadowRadius
            layer.shadowOffset = reusableStyle.shadowOffset
        }
    }
    
    private func reloadStyle() {
        reusableStyle = loadStyle()
    }

}
