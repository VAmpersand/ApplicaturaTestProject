import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()

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

extension CoreDataManager {
    func saveInCoreDataWith(array: [CityData]) {
        array.forEach { cityData in
            do {
                try persistentContainer.viewContext.save()
            } catch let error {
                print(error)
            }
        }
    }

    @discardableResult
    func createCityData(id: Int32,
                        name: String,
                        state: String,
                        country: String,
                        coord: Coord) -> CityData? {
        let context = persistentContainer.viewContext
        let cityData = NSEntityDescription.insertNewObject(forEntityName: "CityData", into: context) as! CityData

        cityData.id = id
        cityData.name = name
        cityData.state = state
        cityData.country = country
        cityData.coord = coord

        do {
            try context.save()
            return cityData
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchCityData() -> [CityData]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")

        do {
            let cityData = try context.fetch(fetchRequest)
            return cityData
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchCityData(withName name: String) -> CityData? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let cityData = try context.fetch(fetchRequest)
            return cityData.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateCityData(cityData: CityData) {
        let context = persistentContainer.viewContext

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteCityData(cityData: CityData) {
        let context = persistentContainer.viewContext
        context.delete(cityData)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }
}

