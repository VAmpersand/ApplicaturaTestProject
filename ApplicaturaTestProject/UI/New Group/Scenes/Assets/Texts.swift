import UIKit

public enum Texts { }

//MARK:- WeatherTable
extension Texts {
    enum WeatherTable {
        static var title: String {
            return "Weather app"
        }
        
        static var addButton: String {
            return "Add city"
        }

    }
}

//MARK:- AddCity
extension Texts {
    enum AddCity {
        static var title: String {
            return "Add city"
        }
        
        static var searchBarPlaceholder: String {
            return "Search"
        }

    }
}


//MARK:- CityWeather
extension Texts {
    enum CityWeather {
        static var title: String {
            return "Weather in"
        }
    }
}
