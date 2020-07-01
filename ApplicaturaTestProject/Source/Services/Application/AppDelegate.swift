import UIKit
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder { }

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        CoreDataService.shared.applicationDocumentsDirectory()
        LocationService.shared
        
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: "com.applicaturaTestProject.apprefresh",
            using: DispatchQueue.global()
        ) { task in
            self.handleAppRefresh(task)
        }
        
        return true
    }
    
    private func handleAppRefresh(_ task: BGTask) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        queue.addOperation {
            CoreDataService.shared.loadPresentedCity { result in
                guard let presentedCities = result.finalResult else { return }
                let url = URLs.urlForSeveralCitiesID(for: presentedCities)
                
                NetworkService.shared.getJSONData(
                    from: url,
                    with: ApiCityWeathers.self
                ) { result, status, error in
                    if status, let cityWeaters = result?.list {
                        cityWeaters.forEach { weather in
                            if let id = weather.id,
                                let presentedCity = presentedCities.first(where: { city in
                                    city.id == id
                                }) {
                                CoreDataService.shared.updateCityWeather(at: presentedCity,
                                                                         whit: weather)
                            }
                        }
                    } else {
                        print(error)
                    }
                }
                
            }
            
            task.expirationHandler = {
                queue.cancelAllOperations()
            }
            
            let lastOperation = queue.operations.last
            lastOperation?.completionBlock = {
                task.setTaskCompleted(success: !(lastOperation?.isCancelled ?? false))
            }
            
            self.scheduleAppRefresh()
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }
    
    private func scheduleAppRefresh() {
        do {
            let request = BGAppRefreshTaskRequest(identifier: "com.applicaturaTestProject.apprefresh")
            request.earliestBeginDate = Date(timeIntervalSinceNow: 3600)
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print(error)
        }
    }
}

