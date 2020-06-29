import UIKit

final class AddCityViewModel {
    
    var router: AddCityRouterProtocol!
    var parentRouter: Router!

    weak var controller: AddCityControllerProtocol?
}

// MARK: - AddCityViewModelProtocol
extension AddCityViewModel: AddCityViewModelProtocol {    
    func handleClose() {
        router.handleClose()
    }
}
