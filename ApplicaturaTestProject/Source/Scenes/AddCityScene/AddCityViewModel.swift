import UIKit

final class AddCityViewModel {
    
    var router: AddCityRouterProtocol!
    var parentRouter: Router!

    weak var controller: AddCityControllerProtocol?
//    
//    private let dependencies: AddCityViewModelDependencyResolver
//    init(injecting dependencies: AddCityViewModelDependencyResolver) {
//        self.dependencies = dependencies
//    }
}

// MARK: - AddCityViewModelProtocol
extension AddCityViewModel: AddCityViewModelProtocol {    
    func handleClose() {
        router.handleClose()
    }
}
