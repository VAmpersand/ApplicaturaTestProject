import UIKit

extension Notification.Name {
    public static var cityWasAdded: Notification.Name {
        return .init("cityWasAdded")
    }
    
    public static var cityDataWasSetup: Notification.Name {
        return .init("cityDataWasSetup")
    }
}
