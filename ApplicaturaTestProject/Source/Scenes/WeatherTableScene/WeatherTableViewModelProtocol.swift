public protocol WeatherTableViewModelProtocol: class {
    func viewDidLoad()
    func presentAddCityScene()
    func presentCityWeatherScene(with cityData: CityData)
}
