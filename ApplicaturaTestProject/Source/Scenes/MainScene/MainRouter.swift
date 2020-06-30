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
            print("Finish")
            
        }
        setupDefaultCity()
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
    func setupDefaultCityData(completon: @escaping () -> Void) {
        if !UserDefaults.cityDataWasSetup {
            let path = Bundle.main.path(forResource: "city.list", ofType: "json")
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: .mappedIfSafe)
                DispatchQueue.global(qos: .utility).async {
                    let cityData = JSONDecoderService.shared.decodeCityData(from: data)
                    CoreDataService.shared.saveInCoreData(citiesData: cityData)
                }
            } catch {
                print(error.localizedDescription)
            }
            completon()
            
            UserDefaults.cityDataWasSetup = true
        }
    }
    
    func setupDefaultCity() {
        let presentedCities = CoreDataService.shared.fetchPresentedCities()
        let location = LocationService.shared.getUserLocation()
        
        if let presentedCities = presentedCities,
            presentedCities.isEmpty {
            let url = URLs.urlForCityWeatherByCoord(withLat: location.lat,
                                                    and: location.lon)
            
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
