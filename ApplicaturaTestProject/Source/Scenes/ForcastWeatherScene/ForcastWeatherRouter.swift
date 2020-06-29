final class ForecastWeatherRouter: BaseRouter {
}

// MARK: - ForecastWeatherRouterProtocol
extension ForecastWeatherRouter: ForecastWeatherRouterProtocol {
    func handleClose() {
        dismissSelf(using: PopoverPresentation())
    }
}
