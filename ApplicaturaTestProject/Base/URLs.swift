import Foundation

public enum URLs {
    static var apiKey: String {
        return "&appid=c5063c53a0152534ff32c42a78c29372"
    }
    
    static var beginningOfUrlForSeveralCitiesId: String {
        return "https://api.openweathermap.org/data/2.5/group?id="
    }
    
    static func urlForCityWeatherByID(for cityData: CityData?) -> String {
          guard let cityData = cityData else { return "" }
          return "https://api.openweathermap.org/data/2.5/weather?id=" + "\(cityData.id)" + apiKey
      }
    
    static func urlForSeveralCitiesID(for presentedCities: [PresentedCity]?) -> String {
        guard let presentedCities = presentedCities else { return "" }
        var citiesIDStr: [String] = []
        presentedCities.forEach { presentedCity in
            if let cityData = presentedCity.cityData {
                citiesIDStr.append(String(cityData.id))
            }
        }
        
        return "https://api.openweathermap.org/data/2.5/group?id=" + citiesIDStr.joined(separator: ",") + apiKey
    }
    
    static func urlForForecastWeatherIn5day(for presentedCity: PresentedCity?) -> String {
        guard let presentedCity = presentedCity else { return "" }
        return "https://api.openweathermap.org/data/2.5/forecast?id=" + "\(presentedCity.id)" + apiKey
    }
    
    static func urlForCityWeatherByCoord(withLat lat: Double?, and lon: Double?) -> String {
         guard let lat = lat, let lon = lon else { return "" }
         return "https://api.openweathermap.org/data/2.5/weather?lat=" + "\(lat)" + "&lon=" + "\(lon)" + apiKey
     }
}
