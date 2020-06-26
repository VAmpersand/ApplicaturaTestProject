import UIKit

final class WeatherTableViewModel {
    
    var router: WeatherTableRouterProtocol!
    var parentRouter: Router!

    weak var controller: WeatherTableControllerProtocol?
    
//    private let dependencies: WeatherTableViewModelDependencyResolver
//    init(injecting dependencies: WeatherTableViewModelDependencyResolver) {
//        self.dependencies = dependencies
//    }
}

// MARK: - WeatherTableViewModelProtocol
extension WeatherTableViewModel: WeatherTableViewModelProtocol {

}