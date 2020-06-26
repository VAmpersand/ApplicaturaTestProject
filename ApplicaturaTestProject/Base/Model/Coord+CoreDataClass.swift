import Foundation
import CoreData


public class Coord: NSManagedObject, Decodable {
    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        let entity = NSEntityDescription.entity(forEntityName: "Coord", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lon = try values.decode(Double.self, forKey: .lon)
        lat = try values.decode(Double.self, forKey: .lat)
    }
}
