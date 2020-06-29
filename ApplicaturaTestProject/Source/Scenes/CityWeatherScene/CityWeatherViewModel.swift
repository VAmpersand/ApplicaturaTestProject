final class CityWeatherViewModel {
    
    // weaver: cityData <= CityData
    
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
    }
    
    func handleClose() {
        router.handleClose()
    }
}
