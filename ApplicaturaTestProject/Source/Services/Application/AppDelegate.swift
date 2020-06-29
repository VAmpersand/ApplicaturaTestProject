import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder { }

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CoreDataService.shared.applicationDocumentsDirectory()

//        if !UserDefaults.cityDataWasSetup {
//            let path = Bundle.main.path(forResource: "city.list", ofType: "json")
//            
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: .mappedIfSafe)
//                DispatchQueue.main.async {
//                    JSONDecoderService.shared.saveCityDataToCoreData(fron: data)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//            
//            UserDefaults.cityDataWasSetup = true
//        }
//        
        return true
    }
}
