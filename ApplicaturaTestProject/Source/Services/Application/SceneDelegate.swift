import UIKit

class SceneDelegate: UIResponder {
    
    // weaver: mainRouter = MainRouter
    // weaver: mainRouter.scope = .container
    
    private let dependencies = SceneDelegateDependencyContainer()
    var window: UIWindow?

}

extension SceneDelegate: UIWindowSceneDelegate {
      func scene(_ scene: UIScene,
                 willConnectTo session: UISceneSession,
                 options connectionOptions: UIScene.ConnectionOptions) {
        
          dependencies.mainRouter.startApp(in: scene)
      }
}

