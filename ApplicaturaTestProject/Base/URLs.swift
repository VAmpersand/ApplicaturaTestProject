import Foundation

public enum URLs {
    static var apiKey: String {
        return "&appid=c5063c53a0152534ff32c42a78c29372"
    }
    
    static var beginningOfUrlForSeveralCitysId: String {
        return "https://api.openweathermap.org/data/2.5/group?id="
    }
    
    static func urlForSeveralCitysID(for presentedCitys: [PresentedCity]?) -> String {
        guard let presentedCitys = presentedCitys else { return "" }
        var citysIDStr: [String] = []
        presentedCitys.forEach { presentedCity in
            if let cityData = presentedCity.cityData {
                citysIDStr.append(String(cityData.id))
            }
        }
        
        return beginningOfUrlForSeveralCitysId + citysIDStr.joined(separator: ",") + apiKey
    }
    
    static func urlForForcastWeatherIn5day(for cityData: CityData?) -> String {
        guard let cityData = cityData else { return "" }
        return "https://api.openweathermap.org/data/2.5/forecast?id=" + "\(cityData.id)" + apiKey
    }    
}
