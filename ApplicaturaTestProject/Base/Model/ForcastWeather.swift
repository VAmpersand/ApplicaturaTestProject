import Foundation

public struct ForcastWeathers: Codable {
    public var list: [ForcastWeather]
    
    init(list: [ForcastWeather]) {
        self.list = list
    }
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}

public struct ForcastWeather: Codable {
    public var weather: [Weather]
    public var main: Main
    public var wind: Wind
    public var clouds: Clouds
    public var dt_txt: String
    
    
    init(weather: [Weather],
         main: Main,
         wind: Wind,
         clouds: Clouds,
         visibility: Int,
         dt_txt: String) {
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.dt_txt = dt_txt
    }
    
    enum CodingKeys: String, CodingKey {
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case dt_txt = "dt_txt"
    }
}
