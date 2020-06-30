public protocol ForecastWeatherControllerProtocol: class {
    func setCityData(_ cityData: CityData)
    func setforecastWeathers(_ forecastWeathers: [CityWeatherApi])
}

