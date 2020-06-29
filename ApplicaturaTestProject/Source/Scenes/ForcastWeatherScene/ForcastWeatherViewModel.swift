final class ForcastWeatherViewModel {
    
    // weaver: cityData <= CityData
    
    // weaver: networkService = NetworkService
    
    var router: ForcastWeatherRouterProtocol!
    var parentRouter: Router!
    weak var controller: ForcastWeatherControllerProtocol?
    
    private let dependencies: ForcastWeatherViewModelDependencyResolver
    init(injecting dependencies: ForcastWeatherViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - ForcastWeatherViewModelProtocol
extension ForcastWeatherViewModel: ForcastWeatherViewModelProtocol {
    func viewDidLoad() {
        controller?.setCityData(dependencies.cityData)
        
        let url = URLs.urlForForcastWeatherIn5day(for: dependencies.cityData)
        
        dependencies.networkService.getJSONData(
            from: url,
            with: CityWeathers.self
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
