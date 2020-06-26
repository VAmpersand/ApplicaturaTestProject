import UIKit.UIViewController

protocol Router: class {
    var childRouters: [Router] { get set }
    var parentRouter: Router? { get set }
    var controller: UIViewController? { get set }
}

extension Router {
    func findRouterInTree<T>() -> T? {
        if let selfT = self as? T {
            return selfT
        }

        for case let childRouter in childRouters {
            if let found: T = childRouter.findRouterInTree() {
                return found
            }
        }

        return nil
    }
}
