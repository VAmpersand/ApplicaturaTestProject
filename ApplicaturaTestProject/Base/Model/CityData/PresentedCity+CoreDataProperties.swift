import Foundation
import CoreData

extension PresentedCity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentedCity> {
        return NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var cityWeather: CityWeather?
}
