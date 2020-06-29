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
        
        do {
            try context.save()
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        comletion?()
    }
    
    func fetchPresentedCity() -> [PresentedCity]? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        
        do {
            let presentedCity = try context.fetch(fetchRequest)
            return presentedCity
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }
        
        return nil
    }
    
    func deletePresentedCity(presentedCity: PresentedCity, comletion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        context.delete(presentedCity)
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
        
        comletion?()
    }
}

