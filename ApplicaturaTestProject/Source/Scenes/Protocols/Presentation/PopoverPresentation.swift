import UIKit

final class PopoverPresentation { }

// MARK: - Presentation
extension PopoverPresentation: Presentation {
    func present(_ controller: UIViewController,
                 from parentController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {
        parentController.present(controller, animated: animated, completion: completion)
    }

    func dismiss(from router: Router, to parentRouter: Router?, animated: Bool, completion: (() -> Void)?) {
        if parentRouter?.controller?.parent != nil {
            parentRouter?.controller?.dismiss(animated: animated, completion: completion)
        } else {
            router.controller?.dismiss(animated: animated, completion: completion)
        }
    }
}
