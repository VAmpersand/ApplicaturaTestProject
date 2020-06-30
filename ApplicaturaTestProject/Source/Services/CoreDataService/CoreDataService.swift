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
    
    func fetchPresentedCitys() -> [PresentedCity]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        
        do {
            let presentedCitys = try context.fetch(fetchRequest)
            return presentedCitys
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
            let presentedCitys = try context.fetch(fetchRequest)
            return presentedCitys.first
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
    
    
    
    
    func setDefaultCity(withLat lat: Double,and lon: Double) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
        fetchRequest.fetchLimit = 1
        let lonPredicate = NSPredicate(format: "coord.lon == %@", lon)
        let latPredicate = NSPredicate(format: "coord.lat == %@", lat)
        fetchRequest.predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [lonPredicate, latPredicate]
        )
        
        do {
            let cityData = try context.fetch(fetchRequest)
            print(cityData)
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }
    }
}

