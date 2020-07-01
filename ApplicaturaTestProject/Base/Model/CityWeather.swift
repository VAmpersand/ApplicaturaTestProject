import Foundation

public struct ApiCityWeathers: Codable {
    public var list: [ApiCityWeather]
    
    init(list: [ApiCityWeather]) {
        self.list = list
    }
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}

public struct ApiCityWeather: Codable {
    public var id: Int32?
    public var sys: System
    public var weather: [Weather]
    public var main: Main
    public var wind: Wind
    public var clouds: Clouds
    public var visibility: Int?
    public var date: String?
    public var name: String?
    
    init(id: Int32,
         sys: System,
         weather: [Weather],
         main: Main,
         wind: Wind,
         clouds: Clouds,
         visibility: Int,
         date: String,
         name: String) {
        self.id = id
        self.sys = sys
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.visibility = visibility
        self.date = date
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sys = "sys"
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case visibility = "visibility"
        case date = "dt_txt"
        case name = "name"
    }
}


public struct System: Codable {
    public var country: String?
    public var timezone: Int?
    public var sunrise: Int?
    public var sunset: Int?

    init(country: String,
        timezone: Int,
         sunrise: Int,
         sunset: Int) {
        self.country = country
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}


public struct Weather: Codable {
    public var main: String?
    public var description: String?
    public var icon: String?
    
    init(main: String,
         description: String,
         icon: String) {
        self.main = main
        self.description = description
        self.icon = icon
    }
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case description = "description"
        case icon = "icon"
    }
}


public struct Main: Codable {
    public var temp: Double?
    public var feelsLike: Double?
    public var pressure: Double?
    public var humidity: Double?
    public var tempMin: Double?
    public var tempMax: Double?
    public var seaLevel: Double?
    public var grndLevel: Double?

    init(temp: Double,
         feelsLike: Double,
         pressure: Double,
         humidity: Double,
         tempMin: Double,
         tempMax: Double,
         seaLevel: Double,
         grndLevel: Double) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}


public struct Wind: Codable {
    public var speed: Double?
    public var deg: Double?
    
    init(speed: Double,
         deg: Double) {
        self.speed = speed
        self.deg = deg
    }
    
    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
    }
}


public struct Clouds: Codable {
    public var all: Double?
    
    init(all: Double) { self.all = all }
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}
