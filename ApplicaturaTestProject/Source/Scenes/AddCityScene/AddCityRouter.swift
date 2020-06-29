final class AddCityRouter: BaseRouter {
}

// MARK: - AddCityRouterProtocol
extension AddCityRouter: AddCityRouterProtocol {
    func handleClose() {
        dismissSelf(using: PopoverPresentation())
    }
}
