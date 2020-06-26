import UIKit

protocol Presentation {
    func dismiss(from router: Router, to parentRouter: Router?, animated: Bool, completion: (() -> Void)?)
    func present(_ controller: UIViewController,
                 from parentController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?)

    func dismiss(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?)
    func present(_ router: Router, from parentRouter: Router, animated: Bool, completion: (() -> Void)?)
}

extension Presentation {
    func present(_ router: Router, from parentRouter: Router, animated: Bool, completion: (() -> Void)?) {
        guard let controller = router.controller, let parentController = parentRouter.controller else { return }

        present(controller, from: parentController, animated: animated, completion: completion)
    }

    func dismiss(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        controller.dismiss(animated: animated, completion: completion)
    }
}
