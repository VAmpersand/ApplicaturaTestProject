//
//  PresentedCity+CoreDataProperties.swift
//  
//
//  Created by Viktor on 30.06.2020.
//
//

import Foundation
import CoreData


extension PresentedCity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentedCity> {
        return NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var cityData: CityData?
    @NSManaged public var coord: Coord?
    @NSManaged public var cityWeather: CityWeather?

}
