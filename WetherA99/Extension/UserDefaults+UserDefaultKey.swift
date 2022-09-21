
import Foundation
import UIKit
extension UserDefaults {
    func value(forKey key: UserDefaultKeys) -> Any? {
        return value(forKey: key.rawValue)
    }
    func double(forKey key: UserDefaultKeys) -> Double? {
        return double(forKey: key.rawValue)
    }
    
    func string(forKey key: UserDefaultKeys) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func float(forKey key: UserDefaultKeys) -> Float? {
        return float(forKey: key.rawValue)
    }
    
    func bool(forKey  key: UserDefaultKeys) -> Bool? {
        return bool(forKey: key.rawValue)
    }
//    func image(forKey key: UserDefaultKeys) -> UIImage? {
//        return image(forKey: key.rawValue)
//    }
    func array(forKey  key: UserDefaultKeys) -> Array<Any>? {
        return array(forKey: key.rawValue)
    }
    func set(_ value: Any?, forKey key: UserDefaultKeys) {
        setValue(value, forKey: key.rawValue)
    }
}
