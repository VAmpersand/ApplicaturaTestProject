public protocol ForecastWeatherControllerProtocol: class {
    func setPresentedCityData(_ presentedCite: PresentedCity)
    func setforecastWeathers(_ forecastWeathers: [ApiCityWeather])
}

