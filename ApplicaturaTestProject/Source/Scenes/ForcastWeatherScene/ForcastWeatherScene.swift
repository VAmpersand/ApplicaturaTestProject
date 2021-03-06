final class ForecastWeatherScene: BaseScene {
    
    // weaver: parentRouter <= Router
    
    // weaver: forecastWeatherRouter = ForecastWeatherRouter
    // weaver: forecastWeatherRouter.scope = .transient
    
    // weaver: forecastWeatherViewModel = ForecastWeatherViewModel
    // weaver: forecastWeatherViewModel.scope = .transient
    
    // weaver: forecastWeatherController = ForecastWeatherController
    // weaver: forecastWeatherController.scope = .transient
    
    // weaver: presentedCity <= PresentedCity
    
    init(injecting dependencies: ForecastWeatherSceneDependencyResolver) {
        let router = dependencies.forecastWeatherRouter
        let viewModel = dependencies.forecastWeatherViewModel(presentedCity: dependencies.presentedCity)
        let controller = dependencies.forecastWeatherController
        
        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller
        
        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
