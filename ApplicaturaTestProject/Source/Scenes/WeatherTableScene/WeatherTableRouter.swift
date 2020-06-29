final class WeatherTableRouter: BaseRouter {
    
    // weaver: addCityScene = AddCityScene
    // weaver: addCityScene.scope = .transient
    
    // weaver: forecastWeatherScene = ForecastWeatherScene
    // weaver: forecastWeatherScene.scope = .transient

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
        let forecastWeatherScene = dependencies.forecastWeatherScene(parentRouter: self,
                                                                     cityData: cityData)
        present(forecastWeatherScene, using: PopoverPresentation())
    }
}
