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
        if let location = LocationService.shared.getUserLocation() {
            self.setupDefaultCity(withLat: location.lat, and: location.lon)
        }
    }
    
    func updataPresentedCities(_ presentedCities: [PresentedCity],
                               completion: @escaping () -> Void) {
        let url = URLs.urlForSeveralCitiesID(for: presentedCities)
        
        print(url)
        
        dependencies.networkService.getJSONData(
            from: url,
            with: ApiCityWeathers.self
        ) { result, status, error in
            if status, let cityWeaters = result?.list {
                print(cityWeaters)
                cityWeaters.forEach { weather in
                    if let id = weather.id,
                        let presentedCity = presentedCities.first(where: { city in
                            city.id == id
                        }) {
                        presentedCity.cityWeather?.clouds = weather.clouds.all ?? 0
                        presentedCity.cityWeather?.temp = weather.main.temp ?? 273
                        presentedCity.cityWeather?.feelsLike = weather.main.feelsLike ?? 273
                        presentedCity.cityWeather?.humidity = weather.main.humidity ?? 0
                        presentedCity.cityWeather?.pressure = weather.main.pressure ?? 0
                        presentedCity.cityWeather?.windSpeed = weather.wind.speed ?? 0
                        
                        CoreDataService.shared.updateCityWeather(at: presentedCity)
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

extension WeatherTableViewModel {
     func setupDefaultCity(withLat lat: Double, and lon: Double) {
         if !UserDefaults.defaultCityWasSetup {
             let url = URLs.urlForCityWeatherByCoord(withLat: lat,
                                                     and: lon)
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
}
