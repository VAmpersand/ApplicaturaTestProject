public protocol WeatherTableViewModelProtocol: class {
    func presentAddCityScene()
    func presentCityWeatherScene(with cityData: CityData)
}
