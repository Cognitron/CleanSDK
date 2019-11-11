
import Foundation
import UIKit

public extension UIView {
    
    func load<T: UIView>(nibNamed nibName: String) -> T {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self).first as! T
    }
    
}
