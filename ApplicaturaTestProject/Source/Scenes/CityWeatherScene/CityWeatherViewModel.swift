final class CityWeatherViewModel {
    
    // weaver: cityData <= CityData
    
    // weaver: networkService = NetworkService
    
    var router: CityWeatherRouterProtocol!
    var parentRouter: Router!
    weak var controller: CityWeatherControllerProtocol?
    
    private let dependencies: CityWeatherViewModelDependencyResolver
    init(injecting dependencies: CityWeatherViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - CityWeatherViewModelProtocol
extension CityWeatherViewModel: CityWeatherViewModelProtocol {
    func viewDidLoad() {
        controller?.setCityData(dependencies.cityData)
        
        let url = URLs.urlForForcastWeatherIn5day(for: dependencies.cityData)
        
        dependencies.networkService.getJSONData(
            from: url,
            with: ForcastWeathers.self
        ) { result, status, error in
            if status, let forcastWeather = result?.list {
                self.controller?.setForcastWeathers(forcastWeather)
            } else {
                print(error)
            }
        }
    }
    
    func handleClose() {
        router.handleClose()
    }
}
