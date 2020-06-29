final class WeatherTableViewModel {
    
    // weaver: networkService = NetworkService
    
    var router: WeatherTableRouterProtocol!
    var parentRouter: Router!
    
    weak var controller: WeatherTableControllerProtocol?
    
    private let dependencies: WeatherTableViewModelDependencyResolver
    init(injecting dependencies: WeatherTableViewModelDependencyResolver) {
        self.dependencies = dependencies
    }
}

// MARK: - WeatherTableViewModelProtocol
extension WeatherTableViewModel: WeatherTableViewModelProtocol {
    func viewDidLoad() {
        let url = URLs.urlForSeveralCitysID(for: CoreDataService.shared.fetchPresentedCity())

        dependencies.networkService.getJSONData(
            from: url,
            with: CityWeathers.self
        ) { result, status, error in
            if status, let cityWeaters = result?.list {
                self.controller?.setWeatherData(cityWeaters)
            } else {
                print(error)
            }
        }

//        let url2 = URLs.urlForForcastWeatherIn5day(for: CoreDataService.shared.fetchPresentedCity()?.first)
//
//        print(url2)
//        dependencies.networkService.getJSONData(
//            from: url2,
//            with: ForcastWeathers.self
//        ) { result, status, error in
//            if status, let cityWeaters = result?.list {
//               print(cityWeaters)
//            } else {
//                print(error)
//            }
//        }
    }
    
    func presentAddCityScene() {
        router.presentAddCityScene()
    }
    
    func presentCityWeatherScene(with cityData: CityData) {
        router.presentCityWeatherScene(with: cityData)
    }
}
