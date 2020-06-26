import UIKit

extension UserDefaults {
    static var cityDataWasSetup: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "cityDataWasSetup")
        } set {
            UserDefaults.standard.set(newValue, forKey: "cityDataWasSetup")
        }
    }
}
