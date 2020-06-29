import Foundation

public struct CityWeathers: Codable {
    public var list: [CityWeather]
    
    init(list: [CityWeather]) {
        self.list = list
    }
    
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }
}

public struct CityWeather: Codable {
    public var id: Int
    public var sys: System
    public var weather: [Weather]
    public var main: Main
    public var wind: Wind
    public var clouds: Clouds
    public var visibility: Int
    
    init(id: Int,
         sys: System,
         weather: [Weather],
         main: Main,
         wind: Wind,
         clouds: Clouds,
         visibility: Int) {
        self.id = id
        self.sys = sys
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.visibility = visibility
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sys = "sys"
        case weather = "weather"
        case main = "main"
        case wind = "wind"
        case clouds = "clouds"
        case visibility = "visibility"
    }
}


public struct System: Codable {
    public var timezone: Int
    public var sunrise: Int
    public var sunset: Int
    
    init(timezone: Int,
         sunrise: Int,
         sunset: Int) {
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    enum CodingKeys: String, CodingKey {
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}


public struct Weather: Codable {
    public var main: String
    public var description: String
    public var icon: String
    
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
    public var temp: Double
    public var feels_like: Double
    public var pressure: Double
    public var humidity: Double
    public var temp_min: Double
    public var temp_max: Double
    public var sea_level: Double?
    public var grnd_level: Double?
    
    init(temp: Double,
         feels_like: Double,
         pressure: Double,
         humidity: Double,
         temp_min: Double,
         temp_max: Double,
         sea_level: Double?,
         grnd_level: Double?) {
        self.temp = temp
        self.feels_like = feels_like
        self.pressure = pressure
        self.humidity = humidity
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.sea_level = sea_level
        self.grnd_level = grnd_level
    }
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feels_like = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case temp_min = "temp_min"
        case temp_max = "temp_max"
        case sea_level = "sea_level"
        case grnd_level = "grnd_level"
    }
}


public struct Wind: Codable {
    public var speed: Double
    public var deg: Double
    
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
    public var all: Double
    
    init(all: Double) { self.all = all }
    
    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}
