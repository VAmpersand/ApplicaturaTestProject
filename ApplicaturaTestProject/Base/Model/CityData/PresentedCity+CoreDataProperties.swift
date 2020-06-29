//
//  PresentedCity+CoreDataProperties.swift
//  
//
//  Created by Viktor on 29.06.2020.
//
//

import Foundation
import CoreData


extension PresentedCity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PresentedCity> {
        return NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
    }

    @NSManaged public var cityData: CityData?

}
