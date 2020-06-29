final class WeatherTableRouter: BaseRouter {
    
    // weaver: addCityScene = AddCityScene
    // weaver: addCityScene.scope = .transient
    
    // weaver: forcastWeatherScene = ForcastWeatherScene
    // weaver: forcastWeatherScene.scope = .transient

    private let dependencies: WeatherTableRouterDependencyResolver
    
    init(injecting dependencies: WeatherTableRouterDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - WeatherTableRouterProtocol
extension WeatherTableRouter: WeatherTableRouterProtocol {
    func presentAddCityScene() {
        let addCityScene = dependencies.addCityScene(parentRouter: self)
        present(addCityScene, using: PopoverPresentation())
    }
    
    func presentCityWeatherScene(with cityData: CityData) {
        let forcastWeatherScene = dependencies.forcastWeatherScene(parentRouter: self,
                                                                   cityData: cityData)
        present(forcastWeatherScene, using: PopoverPresentation())
    }
}
