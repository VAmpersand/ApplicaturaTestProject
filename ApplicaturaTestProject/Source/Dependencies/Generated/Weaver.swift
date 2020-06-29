/// This file is generated by Weaver 0.12.3
/// DO NOT EDIT!
import Alamofire
import CoreData
import Foundation
import SnapKit
import UIKit
// MARK: - ForecastWeatherViewModel
protocol ForecastWeatherViewModelDependencyResolver {
    var cityData: CityData { get }
    var networkService: NetworkService { get }
}
final class ForecastWeatherViewModelDependencyContainer: ForecastWeatherViewModelDependencyResolver {
    let cityData: CityData
    private var _networkService: NetworkService?
    var networkService: NetworkService {
        if let value = _networkService { return value }
        let value = NetworkService()
        _networkService = value
        return value
    }
    init(cityData: CityData) {
        self.cityData = cityData
        _ = networkService
    }
}
// MARK: - AddCityScene
protocol AddCitySceneDependencyResolver {
    var parentRouter: Router { get }
    var addCityRouter: AddCityRouter { get }
    var addCityViewModel: AddCityViewModel { get }
    var addCityController: AddCityController { get }
}
final class AddCitySceneDependencyContainer: AddCitySceneDependencyResolver {
    let parentRouter: Router
    var addCityRouter: AddCityRouter {
        let value = AddCityRouter()
        return value
    }
    var addCityViewModel: AddCityViewModel {
        let value = AddCityViewModel()
        return value
    }
    var addCityController: AddCityController {
        let value = AddCityController()
        return value
    }
    init(parentRouter: Router) {
        self.parentRouter = parentRouter
    }
}
// MARK: - ForecastWeatherScene
protocol ForecastWeatherSceneDependencyResolver {
    var parentRouter: Router { get }
    var cityData: CityData { get }
    var forecastWeatherRouter: ForecastWeatherRouter { get }
    func forecastWeatherViewModel(cityData: CityData) -> ForecastWeatherViewModel
    var forecastWeatherController: ForecastWeatherController { get }
}
final class ForecastWeatherSceneDependencyContainer: ForecastWeatherSceneDependencyResolver {
    let parentRouter: Router
    let cityData: CityData
    var forecastWeatherRouter: ForecastWeatherRouter {
        let value = ForecastWeatherRouter()
        return value
    }
    func forecastWeatherViewModel(cityData: CityData) -> ForecastWeatherViewModel {
        let dependencies = ForecastWeatherViewModelDependencyContainer(cityData: cityData)
        let value = ForecastWeatherViewModel(injecting: dependencies)
        return value
    }
    var forecastWeatherController: ForecastWeatherController {
        let value = ForecastWeatherController()
        return value
    }
    init(parentRouter: Router, cityData: CityData) {
        self.parentRouter = parentRouter
        self.cityData = cityData
    }
}
// MARK: - WeatherTableRouter
protocol WeatherTableRouterDependencyResolver {
    func addCityScene(parentRouter: Router) -> AddCityScene
    func forecastWeatherScene(parentRouter: Router, cityData: CityData) -> ForecastWeatherScene
}
final class WeatherTableRouterDependencyContainer: WeatherTableRouterDependencyResolver {
    func addCityScene(parentRouter: Router) -> AddCityScene {
        let dependencies = AddCitySceneDependencyContainer(parentRouter: parentRouter)
        let value = AddCityScene(injecting: dependencies)
        return value
    }
    func forecastWeatherScene(parentRouter: Router, cityData: CityData) -> ForecastWeatherScene {
        let dependencies = ForecastWeatherSceneDependencyContainer(parentRouter: parentRouter, cityData: cityData)
        let value = ForecastWeatherScene(injecting: dependencies)
        return value
    }
    init() {
    }
}
// MARK: - WeatherTableScene
protocol WeatherTableSceneDependencyResolver {
    var parentRouter: Router { get }
    var weatherTableRouter: WeatherTableRouter { get }
    var weatherTableViewModel: WeatherTableViewModel { get }
    var weatherTableController: WeatherTableController { get }
}
final class WeatherTableSceneDependencyContainer: WeatherTableSceneDependencyResolver {
    let parentRouter: Router
    var weatherTableRouter: WeatherTableRouter {
        let value = WeatherTableRouter(injecting: WeatherTableRouterDependencyContainer())
        return value
    }
    var weatherTableViewModel: WeatherTableViewModel {
        let value = WeatherTableViewModel(injecting: WeatherTableViewModelDependencyContainer())
        return value
    }
    var weatherTableController: WeatherTableController {
        let value = WeatherTableController()
        return value
    }
    init(parentRouter: Router) {
        self.parentRouter = parentRouter
    }
}
// MARK: - WeatherTableViewModel
protocol WeatherTableViewModelDependencyResolver {
    var networkService: NetworkService { get }
}
final class WeatherTableViewModelDependencyContainer: WeatherTableViewModelDependencyResolver {
    private var _networkService: NetworkService?
    var networkService: NetworkService {
        if let value = _networkService { return value }
        let value = NetworkService()
        _networkService = value
        return value
    }
    init() {
        _ = networkService
    }
}
// MARK: - MainRouter
protocol MainRouterDependencyResolver {
    func weatherTableScene(parentRouter: Router) -> WeatherTableScene
}
final class MainRouterDependencyContainer: MainRouterDependencyResolver {
    func weatherTableScene(parentRouter: Router) -> WeatherTableScene {
        let dependencies = WeatherTableSceneDependencyContainer(parentRouter: parentRouter)
        let value = WeatherTableScene(injecting: dependencies)
        return value
    }
    init() {
    }
}
// MARK: - SceneDelegate
protocol SceneDelegateDependencyResolver {
    var mainRouter: MainRouter { get }
}
final class SceneDelegateDependencyContainer: SceneDelegateDependencyResolver {
    private var _mainRouter: MainRouter?
    var mainRouter: MainRouter {
        if let value = _mainRouter { return value }
        let value = MainRouter(injecting: MainRouterDependencyContainer())
        _mainRouter = value
        return value
    }
    init() {
        _ = mainRouter
    }
}