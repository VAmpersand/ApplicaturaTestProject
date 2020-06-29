public protocol ForcastWeatherControllerProtocol: class {
    func setCityData(_ cityData: CityData)
    func setForcastWeathers(_ forcastWeathers: [CityWeather])
}

