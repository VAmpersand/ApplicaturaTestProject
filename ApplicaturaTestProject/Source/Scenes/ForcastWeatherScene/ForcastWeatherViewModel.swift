final class ForecastWeatherViewModel {
    
    // weaver: cityData <= CityData
    
    // weaver: networkService = NetworkService
    
    var router: ForecastWeatherRouterProtocol!
    var parentRouter: Router!
    weak var controller: ForecastWeatherControllerProtocol?
    
    private let dependencies: ForecastWeatherViewModelDependencyResolver
    init(injecting dependencies: ForecastWeatherViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - ForecastWeatherViewModelProtocol
extension ForecastWeatherViewModel: ForecastWeatherViewModelProtocol {
    func viewDidLoad() {
        controller?.setCityData(dependencies.cityData)
        
        let url = URLs.urlForForecastWeatherIn5day(for: dependencies.cityData)
        
        dependencies.networkService.getJSONData(
            from: url,
            with: CityWeathers.self
        ) { result, status, error in
            if status, let forecastWeather = result?.list {
                self.controller?.setforecastWeathers(forecastWeather)
            } else {
                print(error)
            }
        }
    }
    
    func handleClose() {
        router.handleClose()
    }
}
