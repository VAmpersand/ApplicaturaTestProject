import Foundation

public enum URLs {
    static var apiKey: String {
        return "&appid=c5063c53a0152534ff32c42a78c29372"
    }
    
    static func urlForSeveralCitysID(for presentedCitys: [PresentedCity]) -> String {
        var citysIDStr: [String] = []
        presentedCitys.forEach { presentedCity in
            if let cityData = presentedCity.cityData {
                citysIDStr.append(String(cityData.id))
            }
        }
        
        return "http://api.openweathermap.org/data/2.5/group?id=" + citysIDStr.joined(separator: ",")
    }
}
