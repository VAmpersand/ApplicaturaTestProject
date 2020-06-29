import UIKit
import CoreData

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var fetchResultsController: NSFetchedResultsController<PresentedCity>!
    private var context = CoreDataService.shared.persistentContainer.viewContext
    
    public lazy var weatherTableView: UITableView = {
        let table = UITableView()
        table.register(CityWeatherCell.self,
                       forCellReuseIdentifier: CityWeatherCell.cellID)
        table.register(WeatherHeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: WeatherHeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        
        view.backgroundColor = .red
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
        view.addSubview(weatherTableView)

    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        weatherTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - WeatherTableControllerProtocol
extension WeatherTableController: WeatherTableControllerProtocol {
 
}

// MARK: - UITableViewDelegate
extension WeatherTableController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
//        categoriesView.moveOut()
//        viewModel.presentNewsInfoScene(with: sortedNewsList[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension WeatherTableController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityWeatherCell.cellID,
            for: indexPath
            ) as? CityWeatherCell else { return UITableViewCell() }
        
        return cell
    }
}

// MARK: - WeatherHeaderCellDelegate
extension WeatherTableController: WeatherHeaderCellDelegate {
    public func addButtonPressed() {
        viewModel.presentAddCityScene()
    }
}
