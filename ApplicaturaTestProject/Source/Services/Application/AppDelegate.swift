import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder { }

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CoreDataService.shared.applicationDocumentsDirectory()

        return true
    }
}
