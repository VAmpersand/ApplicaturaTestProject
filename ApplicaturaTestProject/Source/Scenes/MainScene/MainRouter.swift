import UIKit

final class MainRouter: BaseRouter {
    
    // weaver: weatherTableScene = WeatherTableScene
    // weaver: weatherTableScene.scope = .transient
    
    // weaver: networkService = NetworkService
    
    private let dependencies: MainRouterDependencyResolver
    
    private var window: UIWindow!
    private var windowScene: UIWindowScene!
    
    init(injecting dependencies: MainRouterDependencyResolver) {
        self.dependencies = dependencies
        super.init()
    }
}

// MARK: - Starting app
extension MainRouter {
    func startApp(in scene: UIScene) {
        setupWindow(in: scene)
        
        setupDefaultCityData() {
            self.setupDefaultCity()
        }
    }
    
    private func setupWindow(in scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Failed to configure windowScene")
        }
        self.windowScene = windowScene
        let weatherTableScene = dependencies.weatherTableScene(parentRouter: self)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window.rootViewController = weatherTableScene.viewController
    }
}

extension MainRouter {
    func setupDefaultCityData(completon: () -> Void) {
        if !UserDefaults.cityDataWasSetup {
            let path = Bundle.main.path(forResource: "city.list", ofType: "json")
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: .mappedIfSafe)
                DispatchQueue.main.async {
                    JSONDecoderService.shared.saveCityDataToCoreData(fron: data)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            UserDefaults.cityDataWasSetup = true
        }
        completon()
    }
    
    func setupDefaultCity() {
        let presentedCities = CoreDataService.shared.fetchPresentedCities()
        
        if let presentedCities = presentedCities,
            presentedCities.isEmpty {
            let url = URLs.urlForCityWeatherByCoord(withLat: UserDefaults.lat,
                                                    and: UserDefaults.lat)
            dependencies.networkService.getJSONData(
                from: url,
                with: ApiCityWeather.self
            ) { result, status, error in
                if status {
                    CoreDataService.shared.setPresentedCity(result) {
                          NotificationCenter.default.post(name: .cityWasAdded, object: nil)
                    }
                } else {
                    print(error)
                }
            }
        }
    }
}
