
import Foundation
import UIKit

@IBDesignable
class NavigationBar: UINavigationBar {
    
    @IBInspectable var backIcon: UIImage! {
        didSet { set(backIcon: backIcon) }
    }
    
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
        shadowImage = UIImage()
        set(backIcon: backIcon)
    }
    
    private func set(backIcon: UIImage!) {
        if let backIcon = backIcon {
            backIndicatorImage = backIcon
            backIndicatorTransitionMaskImage = backIcon
        }
    }

}
