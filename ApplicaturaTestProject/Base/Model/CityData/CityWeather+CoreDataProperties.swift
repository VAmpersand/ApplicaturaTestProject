//
//  CityWeather+CoreDataProperties.swift
//  
//
//  Created by Viktor on 30.06.2020.
//
//

import Foundation
import CoreData


extension CityWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityWeather> {
        return NSFetchRequest<CityWeather>(entityName: "CityWeather")
    }

    @NSManaged public var temp: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var clouds: Double
    @NSManaged public var humidity: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var pressure: Double

}
