import UIKit
import CoreData

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var fetchResultsController: NSFetchedResultsController<PresentedCity>!
    private var context = CoreDataService.shared.persistentContainer.viewContext
    
    private var cityWeathers: [CityWeather] = [] {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).withAlphaComponent(0.3)
        
        return view
    }()
    
    public lazy var weatherTableView: UITableView = {
        let table = UITableView()
        table.register(CityWeatherCell.self,
                       forCellReuseIdentifier: CityWeatherCell.cellID)
        table.register(WeatherHeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: WeatherHeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).withAlphaComponent(0.3)
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        loadData()
        addObservers()
    }
    
    override func addNavigationBar() {
        super.addNavigationBar()
        let navigationBarTuple = addStaticNavigationBar(
            StaticNavigationBar(title: Texts.WeatherTable.title)
        )
        navigationBar = navigationBarTuple.navigationBar
        navigationBar.textAligment = .center
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(containerView)
        containerView.addSubview(weatherTableView)
        
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - WeatherTableControllerProtocol
extension WeatherTableController: WeatherTableControllerProtocol {
    public func setWeatherData(_ cityWeathers: [CityWeather]) {
        self.cityWeathers = cityWeathers
    }
}

// MARK: - UITableViewDataSource
extension WeatherTableController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchResultsController.sections else { return 0 }
        return sections.count
    }
    
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: CityWeatherCell.cellID,
                                                  for: indexPath) as! CityWeatherCell
        
        let presentedCity = fetchResultsController.object(at: indexPath)
        guard let cityData = presentedCity.cityData else { return cell }
        cell.setCityLabel(cityData)
        
        let currentWeather = cityWeathers.first { cityWeather in
            guard let id = cityWeather.id else { return false }
            return id == cityData.id
        }
        guard let weatherData = currentWeather else { return cell }
        cell.setWeatherData(weatherData)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WeatherTableController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView,
                          viewForHeaderInSection section: Int) -> UIView? {
        let cell = WeatherHeaderCell()
        cell.delegate = self
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let presentedCity = fetchResultsController.object(at: indexPath)
        
        guard let cityData = presentedCity.cityData else { return }
        viewModel.presentCityWeatherScene(with: cityData)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive , title: "Delete") { (_, action, completion) in
            
            let presentedCity = self.fetchResultsController.object(at: indexPath)
            CoreDataService.shared.deletePresentedCity(presentedCity: presentedCity) {
                self.loadData()
            }
            
            completion(true)
        }
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension WeatherTableController: NSFetchedResultsControllerDelegate {
    func loadData() {
        let fetchRequest = NSFetchRequest<PresentedCity>(entityName: "PresentedCity")
        
        fetchRequest.sortDescriptors = []
        fetchRequest.fetchBatchSize = 20
        
        fetchResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                            managedObjectContext: context,
                                                            sectionNameKeyPath: nil,
                                                            cacheName: nil)
        fetchResultsController.delegate = self
        
        do {
            try fetchResultsController.performFetch()
        } catch {
            print("Failed to fetch companies: \(error)")
        }
        
        viewModel.viewDidLoad()
        weatherTableView.reloadData()
    }
}


// MARK: - WeatherHeaderCellDelegate
extension WeatherTableController: WeatherHeaderCellDelegate {
    public func addButtonPressed() {
        viewModel.presentAddCityScene()
    }
}

private extension WeatherTableController {
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(cityWasAdded),
                                               name: .cityWasAdded,
                                               object: nil)
    }
    
    @objc func cityWasAdded() {
        loadData()
    }
}
