import UIKit.UIViewController

class BaseScene: Scene {
    enum EmbeddationStyle {
        case none
        case navigation
        case hiddenNavigation
    }

    var viewController: UIViewController?
    var router: Router

    init(viewController: UIViewController?,
         router: Router,
         parentRouter: Router? = nil,
         embeddationStyle: EmbeddationStyle = .none) {
        self.viewController = viewController
        self.router = router

        router.parentRouter = parentRouter
        router.controller = viewController
    }
}
