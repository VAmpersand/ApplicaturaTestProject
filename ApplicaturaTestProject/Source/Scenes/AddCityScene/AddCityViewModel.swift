import UIKit

final class AddCityViewModel {
     
    // weaver: networkService = NetworkService
    
    var router: AddCityRouterProtocol!
    var parentRouter: Router!
    weak var controller: AddCityControllerProtocol?
    
    private let dependencies: AddCityViewModelDependencyResolver
    init(injecting dependencies: AddCityViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - AddCityViewModelProtocol
extension AddCityViewModel: AddCityViewModelProtocol {
    func addPresentCity(with cityData: CityData) {
        let url = URLs.urlForCityWeatherByID(for: cityData)
 
        dependencies.networkService.getJSONData(
            from: url,
            with: ApiCityWeather.self
        ) { result, status, error in
            if status, let cityWeater = result {
                CoreDataService.shared.setPresentedCity(cityWeater) {
                    NotificationCenter.default.post(name: .cityWasAdded, object: nil)
                }
            } else {
                print(error)
            }
        }
    }
    
    func handleClose() {
        router.handleClose()
    }
}
