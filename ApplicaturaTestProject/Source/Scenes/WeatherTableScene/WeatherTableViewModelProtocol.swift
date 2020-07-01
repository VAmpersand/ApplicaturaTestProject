public protocol WeatherTableViewModelProtocol: class {
    func viewDidLoad(with presentedCities: [PresentedCity])
    func presentAddCityScene()
    func presentCityWeatherScene(with presentedCity: PresentedCity)
}
