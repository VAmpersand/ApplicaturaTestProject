import UIKit.UIViewController

class BaseRouter: Router {
    var childRouters: [Router] = []
    var controller: UIViewController?
    var parentRouter: Router?
}

// MARK: - Presenting
extension BaseRouter {
    func present(_ scene: Scene,
                 using presentation: Presentation,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) {
        presentation.present(scene.router, from: self, animated: animated, completion: completion)
        childRouters.append(scene.router)
    }

    func present(_ router: Router,
                 using presentation: Presentation,
                 animated: Bool = true,
                 completion: (() -> Void)? = nil) {
        presentation.present(router, from: self, animated: animated, completion: completion)
        childRouters.append(router)
    }
}

// MARK: - Dismissing
extension BaseRouter {
    func dismiss(using presentation: Presentation,
                 from scene: Scene,
                 to parentScene: Scene?,
                 animated: Bool,
                 completion: (() -> Void)?) {
        presentation.dismiss(from: scene.router, to: parentScene?.router, animated: animated, completion: completion)
    }

    func dismiss(using presentation: Presentation,
                 from router: Router,
                 to parentRouter: Router?,
                 animated: Bool,
                 completion: (() -> Void)?) {
        presentation.dismiss(from: router, to: parentRouter, animated: animated, completion: completion)

        guard let selfInParentChildRoutersIndex = parentRouter?.childRouters.firstIndex(where: { $0 === self }) else {
            return
        }

        parentRouter?.childRouters.remove(at: selfInParentChildRoutersIndex)
    }

    func dismissSelf(using presentation: Presentation, animated: Bool = true, completion: (() -> Void)? = nil) {
        dismiss(using: presentation, from: self, to: parentRouter, animated: animated, completion: completion)
    }
}
