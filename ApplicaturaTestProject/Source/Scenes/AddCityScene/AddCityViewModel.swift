import UIKit

final class AddCityViewModel {
    
    // weaver: coreDataService = CoreDataService
    
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
    func viewDidLoad() {
        let cityData = self.dependencies.coreDataService.fetchCityData()
        self.controller?.setupCityData(cityData)
    }
    
    func handleClose() {
        router.handleClose()
    }
}
