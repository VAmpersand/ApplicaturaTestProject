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
    func viewDidLoad() {
        LocationService.shared
        print(LocationService.shared.getUserLocation())
        if let location = LocationService.shared.getUserLocation() {
            self.setupDefaultCity(withLat: location.lat, and: location.lon)
        }
        
        
//        let url = URLs.urlForSeveralCitiesID(for: presentedCities)
//
//        dependencies.networkService.getJSONData(
//            from: url,
//            with: ApiCityWeathers.self
//        ) { result, status, error in
//            if status, let cityWeaters = result?.list {
//
//                cityWeaters.forEach { weather in
//                    if let id = weather.id,
//                        let presentedCity = CoreDataService.shared.fetchPresentedCity(with: Int32(id)),
//                        let cityWeather = presentedCity.cityWeather {
//                        
//                        cityWeather.clouds = weather.clouds.all ?? 0
//                        cityWeather.temp = weather.main.temp ?? 273
//                        cityWeather.feelsLike = weather.main.feelsLike ?? 273
//                        cityWeather.humidity = weather.main.humidity ?? 0
//                        cityWeather.pressure = weather.main.pressure ?? 0
//                        cityWeather.windSpeed = weather.wind.speed ?? 0
//                        
//                        CoreDataService.shared.updateCityWeather(cityWeather)
//                    }
//                }
                
//                self.controller?.setWeatherData(cityWeaters)
//            } else {
//                print(error)
//            }
//        }
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
