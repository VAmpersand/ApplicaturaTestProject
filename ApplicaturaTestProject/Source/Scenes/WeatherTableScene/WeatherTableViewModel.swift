import UIKit

final class WeatherTableViewModel {
    
    // weaver: networkService = NetworkService
    
    var router: WeatherTableRouterProtocol!
    var parentRouter: Router!
    
    weak var controller: WeatherTableControllerProtocol?
    
    private let dependencies: WeatherTableViewModelDependencyResolver
    init(injecting dependencies: WeatherTableViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - WeatherTableViewModelProtocol
extension WeatherTableViewModel: WeatherTableViewModelProtocol {
    func setupDefaultCity() {
        if let location = LocationService.shared.getUserLocation(),
            !UserDefaults.defaultCityWasSetup {
            let url = URLs.urlForCityWeatherByCoord(withLat: location.lat,
                                                    and: location.lon)
            DispatchQueue.global(qos: .utility).async {
                self.dependencies.networkService.getJSONData(
                    from: url,
                    with: ApiCityWeather.self
                ) { result, status, error in
                    if status {
                        CoreDataService.shared.setPresentedCityData(result) {
                            NotificationCenter.default.post(name: .cityWasAdded, object: nil)
                            UserDefaults.defaultCityWasSetup = true
                        }
                    } else {
                        print(error)
                    }
                }
            }
        }
    }
    
    func updataPresentedCities(_ presentedCities: [PresentedCity],
                               completion: @escaping () -> Void) {
        let url = URLs.urlForSeveralCitiesID(for: presentedCities)
        
        dependencies.networkService.getJSONData(
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
                completion()
            } else {
                print(error)
            }
        }
    }
    
    func presentAddCityScene() {
        router.presentAddCityScene()
    }
    
    func presentCityWeatherScene(with presentedCity: PresentedCity) {
        router.presentCityWeatherScene(with: presentedCity)
    }
}

