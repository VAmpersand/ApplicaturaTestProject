final class ForcastWeatherRouter: BaseRouter {

}

// MARK: - ForcastWeatherRouterProtocol
extension ForcastWeatherRouter: ForcastWeatherRouterProtocol {
    func handleClose() {
        dismissSelf(using: PopoverPresentation())
    }
}
