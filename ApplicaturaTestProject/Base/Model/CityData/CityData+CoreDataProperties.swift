import Foundation
import CoreData

extension CityData {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityData> {
        return NSFetchRequest<CityData>(entityName: "CityData")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var coord: Coord?
}
