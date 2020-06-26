import UIKit

final class CityWeatherViewModel {
    
    var router: CityWeatherRouterProtocol!
    var parentRouter: Router!

    weak var controller: CityWeatherControllerProtocol?
    
//    private let dependencies: CityWeatherViewModelDependencyResolver
//    init(injecting dependencies: CityWeatherViewModelDependencyResolver) {
//        self.dependencies = dependencies
//    }
}

// MARK: - CityWeatherViewModelProtocol
extension CityWeatherViewModel: CityWeatherViewModelProtocol {

}
