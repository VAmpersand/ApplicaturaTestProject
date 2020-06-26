final class WeatherTableScene: BaseScene {
    
    // weaver: parentRouter <= Router
    
    // weaver: weatherTableRouter = WeatherTableRouter
    // weaver: weatherTableRouter.scope = .transient
    
    // weaver: weatherTableViewModel = WeatherTableViewModel
    // weaver: weatherTableViewModel.scope = .transient
    
    // weaver: weatherTableController = WeatherTableController
    // weaver: weatherTableController.scope = .transient
    
    init(injecting dependencies: WeatherTableSceneDependencyResolver) {
        let router = dependencies.weatherTableRouter
        let viewModel = dependencies.weatherTableViewModel
        let controller = dependencies.weatherTableController
        
        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller
        
        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
