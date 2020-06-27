import Foundation
import CoreData


public class CityData: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case state = "state"
        case country = "country"
        case coord = "coord"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing")
        }
        let entity = NSEntityDescription.entity(forEntityName: "CityData",
                                                in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int32.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        state = try values.decode(String.self, forKey: .state)
        country = try values.decode(String.self, forKey: .country)
        coord = try values.decode(Coord.self, forKey: .coord)
    }
}
