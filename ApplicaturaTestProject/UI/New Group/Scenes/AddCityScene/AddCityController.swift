import UIKit
import CoreData

public final class AddCityController: BaseController {
    public var viewModel: AddCityViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var fetchResultsController: NSFetchedResultsController<CityData>!
    private var context = CoreDataService.shared.persistentContainer.viewContext

    
    public lazy var cityTableView: UITableView = {
        let table = UITableView()
        table.register(CityCell.self,
                       forCellReuseIdentifier: CityCell.cellID)
        table.register(CityHeaderCell.self,
                       forHeaderFooterViewReuseIdentifier: CityHeaderCell.cellID)
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
}

extension AddCityController {
    override func setupSelf() {
        super.setupSelf()
        loadData()
        view.backgroundColor = .red
    }
    
    override func addNavigationBar() {
        super.addNavigationBar()
        let navigationBarTuple = addStaticNavigationBar(
            StaticNavigationBar(title: Texts.AddCity.title,
                                rightButtonImage: Icons.AddCity.close,
                                rightAction: { self.viewModel.handleClose() }
            )
        )
        navigationBar = navigationBarTuple.navigationBar
        navigationBar.textAligment = .center
        closeButton = navigationBarTuple.rightButton
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
    public func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchResultsController.sections else { return 0 }
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchResultsController.sections else { return nil }
        return sections[section].indexTitle ?? ""
    }
    
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.cellID,
                                                 for: indexPath) as! CityCell
        let cityData = fetchResultsController.object(at: indexPath)
        cell.setCityLabel(cityData)
        
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
        let cityData = fetchResultsController.object(at: indexPath)
        CoreDataService.shared.savePresentedCity(cityDate: cityData)
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.handleClose()
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension AddCityController: NSFetchedResultsControllerDelegate {
    func loadData() {
        let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
        let countryDescriptor = NSSortDescriptor(key: "country", ascending: true)
        let cityDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [countryDescriptor, cityDescriptor]
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
        cityTableView.reloadData()
    }
}

// MARK: - UISearchBarDelegate
extension AddCityController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            
            let fetchRequest = NSFetchRequest<CityData>(entityName: "CityData")
            
            let countryDescriptor = NSSortDescriptor(key: "country", ascending: true)
            let cityDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [countryDescriptor, cityDescriptor]
            fetchRequest.fetchBatchSize = 20
            
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased())
            
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
            
            cityTableView.reloadData()
        } else {
            loadData()
        }
    }
}
