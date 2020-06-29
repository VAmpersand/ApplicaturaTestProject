final class CityWeatherScene: BaseScene {
    
    // weaver: parentRouter <= Router
    
    // weaver: cityWeatherRouter = CityWeatherRouter
    // weaver: cityWeatherRouter.scope = .transient
    
    // weaver: cityWeatherViewModel = CityWeatherViewModel
    // weaver: cityWeatherViewModel.scope = .transient
    
    // weaver: cityWeatherController = CityWeatherController
    // weaver: cityWeatherController.scope = .transient
    
    // weaver: cityData <= CityData
    
    init(injecting dependencies: CityWeatherSceneDependencyResolver) {
        let router = dependencies.cityWeatherRouter
        let viewModel = dependencies.cityWeatherViewModel(cityData: dependencies.cityData)
        let controller = dependencies.cityWeatherController
        
        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller
        
        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
