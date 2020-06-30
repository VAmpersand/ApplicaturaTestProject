import CoreData

struct CoreDataService {
    static let shared = CoreDataService()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CityData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }
        
        return container
    }()
    
    func applicationDocumentsDirectory() {
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}

extension CoreDataService {
    func saveInCoreDataWith(array: [CityData]) {
        array.forEach { cityData in
            do {
                try persistentContainer.viewContext.save()
            } catch let error {
                print(error)
            }
        }
    }
    
    func savePresentedCity(cityDate: CityData, comletion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        let presentedCity = NSEntityDescription.insertNewObject(forEntityName: "PresentedCity",
                                                                into: context) as! PresentedCity
        
        presentedCity.cityData = cityDate
        presentedCity.coord = cityDate.coord
        presentedCity.id = cityDate.id
        
        do {
            try context.save()
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        comletion?()
    }
    
    func fetchPresentedCities() -> [PresentedCity]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        
        do {
            let presentedCities = try context.fetch(fetchRequest)
            return presentedCities
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchPresentedCity(with id: Int32) -> PresentedCity? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let presentedCities = try context.fetch(fetchRequest)
            return presentedCities.first
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }
        
        return nil
    }
    
    func updateCityWeather(_ cityWeather: CityWeather) {
         let context = persistentContainer.viewContext

         do {
             try context.save()
         } catch let createError {
             print("Failed to update: \(createError)")
         }
     }
    
    
    func deletePresentedCity(_ presentedCity: PresentedCity, comletion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        context.delete(presentedCity)
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
        
        comletion?()
    }
    
    
    func setDefaultCity(_ cityWeather: CityWeatherApi, comletion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        
        let presentedCity = NSEntityDescription.insertNewObject(forEntityName: "PresentedCity",
                                                                into: context) as! PresentedCity
        presentedCity.id = cityWeather.id ?? 0
        presentedCity.cityWeather?.clouds = cityWeather.clouds.all ?? 0
        presentedCity.cityWeather?.feelsLike = cityWeather.main.feelsLike ?? 273
        presentedCity.cityWeather?.temp = cityWeather.main.temp ?? 273
        presentedCity.cityWeather?.pressure = cityWeather.main.pressure ?? 0
        presentedCity.cityWeather?.humidity = cityWeather.main.humidity ?? 0
        presentedCity.cityWeather?.windSpeed = cityWeather.wind.speed ?? 0
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
        
        comletion?()
    }
    
}
