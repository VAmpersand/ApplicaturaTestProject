import CoreData
import UIKit

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
    func setupCitiesData(citiesData: [CityData]) {
        let contex = persistentContainer.viewContext
        
        persistentContainer.performBackgroundTask { contex in
            citiesData.forEach { data in
                let cityData = CityData(context: contex)
                cityData.id = data.id
                cityData.name = data.name
                cityData.country = data.country
                cityData.state = data.state
            }
        }
        do {
            try contex.save()
        } catch let error {
            print(error)
        }
        
    }
    
    func updateCityWeather(at presentedCity: PresentedCity) {
        persistentContainer.performBackgroundTask { context in
            do {
                try context.save()
            } catch let saveError {
                print("Failed to setup: \(saveError)")
            }
        }
    }
    
    
    func deletePresentedCity(_ presentedCity: PresentedCity, comletion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        context.delete(presentedCity)
        
        do {
            try context.save()
        } catch let saveError {
            print("Failed to setup: \(saveError)")
        }
        comletion?()
    }
    
    
    func setPresentedCityData(_ cityWeatherApi: ApiCityWeather?, comletion: (() -> Void)? = nil) {
        guard let cityWeatherApi = cityWeatherApi else { return }
   
        persistentContainer.performBackgroundTask { context in
            let presentedCity = NSEntityDescription.insertNewObject(forEntityName: "PresentedCity",
                                                                    into: context) as! PresentedCity
            presentedCity.id = cityWeatherApi.id ?? 0
            presentedCity.name = cityWeatherApi.name ?? "Weather in your area"
            
            let cityWeather = NSEntityDescription.insertNewObject(forEntityName: "CityWeather",
                                                                  into: context) as! CityWeather
            cityWeather.clouds = cityWeatherApi.clouds.all ?? 0
            cityWeather.feelsLike = cityWeatherApi.main.feelsLike ?? 273
            cityWeather.temp = cityWeatherApi.main.temp ?? 273
            cityWeather.pressure = cityWeatherApi.main.pressure ?? 0
            cityWeather.humidity = cityWeatherApi.main.humidity ?? 0
            cityWeather.windSpeed = cityWeatherApi.wind.speed ?? 0
            
            presentedCity.cityWeather = cityWeather
            
            do {
                try context.save()
            } catch let saveError {
                print("Failed to setup: \(saveError)")
            }
            comletion?()
        }
    }
    
    func loadPresentedCity(completion: @escaping (NSAsynchronousFetchResult<PresentedCity>) -> Void) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        let cityDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [cityDescriptor]
        fetchRequest.fetchBatchSize = 20
     
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(
            fetchRequest: fetchRequest
        ) { asynchronousFetchResult in
            DispatchQueue.main.async {
                completion(asynchronousFetchResult)
            }
        }
        
        do {
            try context.execute(asynchronousFetchRequest)
        } catch {
            let fetchError = error as NSError
            print("Failed to fetch companie: \(fetchError)")
        }
    }
    
    func loadCityData(with searchText: String? = nil,
                      completion: @escaping (NSAsynchronousFetchResult<CityData>) -> Void) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
        let countryDescriptor = NSSortDescriptor(key: "country", ascending: true)
        let cityDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [countryDescriptor, cityDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        if let searchText = searchText  {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased())
        }
        
        let asynchronousFetchRequest = NSAsynchronousFetchRequest(
            fetchRequest: fetchRequest
        ) { asynchronousFetchResult in
            DispatchQueue.main.async {
                completion(asynchronousFetchResult)
            }
        }
        
        do {
            try context.execute(asynchronousFetchRequest)
        } catch {
            let fetchError = error as NSError
            print("Failed to fetch companie: \(fetchError)")
        }
    }
}
