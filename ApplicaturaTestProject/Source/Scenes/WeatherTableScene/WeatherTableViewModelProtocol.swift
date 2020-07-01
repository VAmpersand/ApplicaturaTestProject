public protocol WeatherTableViewModelProtocol: class {
    func setupDefaultCity()
    func presentAddCityScene()
    func presentCityWeatherScene(with presentedCity: PresentedCity)
    func updataPresentedCities(_ presentedCities: [PresentedCity],
                               completion: @escaping () -> Void)
}
