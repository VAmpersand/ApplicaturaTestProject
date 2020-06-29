public protocol CityWeatherControllerProtocol: class {
    func setCityData(_ cityData: CityData)
    func setForcastWeathers(_ forcastWeathers: [ForcastWeather])
}

