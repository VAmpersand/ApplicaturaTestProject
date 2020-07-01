import UIKit
import CoreData

public final class AddCityController: BaseController {
    public var viewModel: AddCityViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var context = CoreDataService.shared.persistentContainer.viewContext
    private var citiesData: [CityData] = []
    
    public lazy var cityTableView: UITableView = {
        let table = UITableView()
        table.register(CityCell.self,
                       forCellReuseIdentifier: CityCell.cellID)
        table.register(CityHeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: CityHeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
}

extension AddCityController {
    override func setupSelf() {
        super.setupSelf()
        CoreDataService.shared.loadCityData() { result in
            self.processAsynchronousFetchResult(asynchronousFetchResult: result)
        }
    }
    
    override func addNavigationBar() {
        super.addNavigationBar()
        let navigationBarTuple = addStaticNavigationBar(
            StaticNavigationBar(title: Texts.AddCity.title,
                                rightButtonImage: Icons.close,
                                rightAction: { self.viewModel.handleClose() }
            )
        )
        navigationBar = navigationBarTuple.navigationBar
        navigationBar.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        navigationBar.titleColor = .white
        navigationBar.textAligment = .center
        closeButton = navigationBarTuple.rightButton
        closeButton.tintColor = .white
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(cityTableView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

// MARK: - AddCityControllerProtocol
extension AddCityController: AddCityControllerProtocol {
}

// MARK: - UITableViewDataSource
extension AddCityController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return citiesData.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.cellID,
                                                 for: indexPath) as! CityCell
        cell.setCityLabel(citiesData[indexPath.row])
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AddCityController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    public func tableView(_ tableView: UITableView,
                          heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    public func tableView(_ tableView: UITableView,
                          viewForHeaderInSection section: Int) -> UIView? {
        let cell = CityHeaderCell()
        cell.searchBar.delegate = self

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.addPresentCity(with: citiesData[indexPath.row])
        self.viewModel.handleClose()
    }
}

// MARK: - UISearchBarDelegate
extension AddCityController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            CoreDataService.shared.loadCityData(with: searchText) { result in
                self.processAsynchronousFetchResult(asynchronousFetchResult: result)
            }
        } else {
            CoreDataService.shared.loadCityData() { result in
                self.processAsynchronousFetchResult(asynchronousFetchResult: result)
            }
        }
    }
}

extension AddCityController {
    func processAsynchronousFetchResult(asynchronousFetchResult: NSAsynchronousFetchResult<CityData>) {
        if let result = asynchronousFetchResult.finalResult {
            DispatchQueue.main.async {
                self.citiesData = result
                self.cityTableView.reloadData()
            }
        }
    }
}
