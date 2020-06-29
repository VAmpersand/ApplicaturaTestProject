final class ForcastWeatherScene: BaseScene {
    
    // weaver: parentRouter <= Router
    
    // weaver: forcastWeatherRouter = ForcastWeatherRouter
    // weaver: forcastWeatherRouter.scope = .transient
    
    // weaver: forcastWeatherViewModel = ForcastWeatherViewModel
    // weaver: forcastWeatherViewModel.scope = .transient
    
    // weaver: forcastWeatherController = ForcastWeatherController
    // weaver: forcastWeatherController.scope = .transient
    
    // weaver: cityData <= CityData
    
    init(injecting dependencies: ForcastWeatherSceneDependencyResolver) {
        let router = dependencies.forcastWeatherRouter
        let viewModel = dependencies.forcastWeatherViewModel(cityData: dependencies.cityData)
        let controller = dependencies.forcastWeatherController
        
        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller
        
        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
