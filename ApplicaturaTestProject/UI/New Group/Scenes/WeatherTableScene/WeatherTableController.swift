import UIKit

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
//    var result: [CityData]?
    
    public lazy var weatherTableView: UITableView = {
        let table = UITableView()
        table.register(CityWeatherCell.self,
                       forCellReuseIdentifier: CityWeatherCell.cellID)
        table.register(HeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: HeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
//        table.refreshControl = self.refreshControll
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        
        view.backgroundColor = .red
        //        let navigationBarTuple = addStaticNavigationBar(
        //            StaticNavigationBar(title: Texts.NewsInfo.title,
        //                                rightButtonImage: Icons.NewsInfo.back,
        //                                rightAction: {
        //                                    self.viewModel.handleClose()
        //            })
        //        )
        //        navigationBar = navigationBarTuple.navigationBar
        //        navigationBar.textAligment = .center
        //        closeButton = navigationBarTuple.rightButton
        
    }
    
    override func addSubviews() {
        super.addSubviews()


    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
 
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
        let cell = HeaderCell()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID",
                                                 for: indexPath)
        
        return cell
    }
}

// MARK: - HeaderCellDelegate
extension WeatherTableController: HeaderCellDelegate {
    public func addButtonPressed() {
        
    }
}
