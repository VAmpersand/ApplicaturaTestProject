import UIKit

extension UserDefaults {
    static var cityDataWasSetup: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "cityDataWasSetup")
        } set {
            UserDefaults.standard.set(newValue, forKey: "cityDataWasSetup")
        }
    }
    
    static var lat: Double? {
        get {
            return UserDefaults.standard.double(forKey: "lat")
        } set {
            UserDefaults.standard.set(newValue, forKey: "lat")
        }
    }
    
    static var lon: Double? {
        get {
            return UserDefaults.standard.double(forKey: "lon")
        } set {
            UserDefaults.standard.set(newValue, forKey: "lon")
        }
    }
}
