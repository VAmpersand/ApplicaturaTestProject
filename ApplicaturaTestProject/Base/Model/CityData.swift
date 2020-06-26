import Foundation

public struct CityData: Codable {
    public var id: Int
    public var name: String
    public var state: String
    public var country: String
    public var coord: Coord
    
    init(id: Int,
         name: String,
         state: String,
         country: String,
         coord: Coord) {
        self.id = id
        self.name = name
        self.state = state
        self.country = country
        self.coord = coord
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case name = "name"
        case state = "state"
        case country = "country"
        case coord = "coord"
    }
}

public struct Coord: Codable {
    public var lon: Double
    public var lat: Double
    
    init(lon: Double,
         lat: Double) {
        self.lon = lon
        self.lat = lat
    }
    
    enum CodingKeys: String, CodingKey{
        case lon = "lon"
        case lat = "lat"
    }
}
