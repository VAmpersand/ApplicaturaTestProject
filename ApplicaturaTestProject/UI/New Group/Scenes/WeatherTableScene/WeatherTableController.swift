import UIKit
import CoreData

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var context = CoreDataService.shared.persistentContainer.viewContext
    private var presentedCities: [PresentedCity] = []
    
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
        table.refreshControl = self.refreshControll
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    private lazy var refreshControll: UIRefreshControl = {
        let controll = UIRefreshControl()
        controll.addTarget(self,
                           action: #selector(refreshControllHandle(sender:)),
                           for: .valueChanged)
        
        return controll
    }()
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        CoreDataService.shared.loadPresentedCity() { result in
            self.processAsynchronousFetchResult(asynchronousFetchResult: result)
        }
        addObservers()
        
//        if !UserDefaults.cityDataWasSetup {
//
//                SVProgressHUD.show(withStatus: "Loading cities")
//
//        }
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
}

// MARK: - Actions
extension WeatherTableController {
    @objc func refreshControllHandle(sender: UIRefreshControl) {
        CoreDataService.shared.loadPresentedCity() { result in
            self.processAsynchronousFetchResult(asynchronousFetchResult: result)
            DispatchQueue.main.async {
                sender.endRefreshing()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension WeatherTableController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return presentedCities.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: CityWeatherCell.cellID,
                                                  for: indexPath) as! CityWeatherCell

        cell.setPresentedCityData(presentedCities[indexPath.row])
        
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
        viewModel.presentCityWeatherScene(with: presentedCities[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive , title: "Delete") { (_, action, completion) in
            CoreDataService.shared.deletePresentedCity(self.presentedCities[indexPath.row]) {
                CoreDataService.shared.loadPresentedCity() { result in
                    self.processAsynchronousFetchResult(asynchronousFetchResult: result)
                }
            }
            
            completion(true)
        }
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension WeatherTableController {
    func processAsynchronousFetchResult(asynchronousFetchResult: NSAsynchronousFetchResult<PresentedCity>) {
        if let result = asynchronousFetchResult.finalResult {
            DispatchQueue.main.async {
                self.presentedCities = result
                self.weatherTableView.reloadData()
            }
        }
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
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(setDefaultCity),
                                               name: .locationServiceWasSetup,
                                               object: nil)
    }
    
    @objc func cityWasAdded() {
        CoreDataService.shared.loadPresentedCity() { result in
            self.processAsynchronousFetchResult(asynchronousFetchResult: result)
        }
    }
    
    @objc func setDefaultCity() {
        viewModel.viewDidLoad()
    }
}
