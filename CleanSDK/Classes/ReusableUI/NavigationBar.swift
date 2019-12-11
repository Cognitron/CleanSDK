
import Foundation
import UIKit

@IBDesignable
class NavigationBar: UINavigationBar {
    
    @IBInspectable var backIcon: UIImage! {
        didSet { set(backIcon: backIcon) }
    }
    
    @IBInspectable var underlineColor: UIColor! {
        didSet { shadowImage = generateUnderlineImage(underlineColor) }
    }
    
//    @IBInspectable var height: CGFloat = 0.0 {
//        didSet { setNeedsLayout() }
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadUI()
    }

    private func loadUI() {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = generateUnderlineImage(nil)
        set(backIcon: backIcon)
    }
    
    private func set(backIcon: UIImage!) {
        if let backIcon = backIcon {
            backIndicatorImage = backIcon
            backIndicatorTransitionMaskImage = backIcon
        }
    }
    
    private func generateUnderlineImage(_ color: UIColor!) -> UIImage {
        guard let color = color else {
            return UIImage()
        }
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        color.setFill()
        ctx?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//
//        if height > 0 {
//            frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: height))
//
//            for subview in self.subviews {
//                var stringFromClass = NSStringFromClass(subview.classForCoder)
//                if stringFromClass.contains("BarBackground") {
//                    subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
//                    subview.backgroundColor = self.backgroundColor
//                }
//
//                stringFromClass = NSStringFromClass(subview.classForCoder)
//                if stringFromClass.contains("BarContent") {
//                    subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: height)
//                    subview.backgroundColor = self.backgroundColor
//                }
//            }
//
//        }
//
//    }

}
