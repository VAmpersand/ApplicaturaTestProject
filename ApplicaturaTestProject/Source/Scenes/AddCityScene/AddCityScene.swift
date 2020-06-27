final class AddCityScene: BaseScene {
    
    // weaver: parentRouter <= Router
    
    // weaver: addCityRouter = AddCityRouter
    // weaver: addCityRouter.scope = .transient
    
    // weaver: addCityViewModel = AddCityViewModel
    // weaver: addCityViewModel.scope = .transient
    
    // weaver: addCityController = AddCityController
    // weaver: addCityController.scope = .transient
    
    init(injecting dependencies: AddCitySceneDependencyResolver) {
        let router = dependencies.addCityRouter
        let viewModel = dependencies.addCityViewModel
        let controller = dependencies.addCityController
        
        controller.viewModel = viewModel
        viewModel.router = router
        viewModel.parentRouter = dependencies.parentRouter
        viewModel.controller = controller
        
        super.init(viewController: controller,
                   router: router,
                   parentRouter: dependencies.parentRouter)
    }
}
