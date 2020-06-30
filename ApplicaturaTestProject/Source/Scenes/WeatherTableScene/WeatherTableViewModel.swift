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
        let url = URLs.urlForSeveralCitysID(for: CoreDataService.shared.fetchPresentedCitys())

        dependencies.networkService.getJSONData(
            from: url,
            with: CityWeathers.self
        ) { result, status, error in
            if status, let cityWeaters = result?.list {
                
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
                
                self.controller?.setWeatherData(cityWeaters)
            } else {
                print(error)
            }
        }
    }
    
    func presentAddCityScene() {
        router.presentAddCityScene()
    }
    
    func presentCityWeatherScene(with cityData: CityData) {
        router.presentCityWeatherScene(with: cityData)
    }
}
