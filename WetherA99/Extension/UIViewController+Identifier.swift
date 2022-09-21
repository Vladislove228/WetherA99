
import Foundation
import UIKit

extension UIViewController {
    private static var identifier: String {
        String(describing: Self.self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        return viewController
    }
}
