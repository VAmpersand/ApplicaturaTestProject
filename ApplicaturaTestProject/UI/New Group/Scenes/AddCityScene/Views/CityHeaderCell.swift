import UIKit

extension AddCityController {
    public class CityHeaderCell: UITableViewHeaderFooterView {
        override public init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: CityHeaderCell.self)
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            
            return view
        }()
        
        public lazy var searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = Texts.AddCity.searchBarPlaceholder
            searchBar.layer.cornerRadius = 10
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.font = UIFont.systemFont(ofSize: 15)
            searchBar.clipsToBounds = true
            searchBar.keyboardAppearance = .dark
            
            return searchBar
        }()
        
    }
}

extension AddCityController.CityHeaderCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(searchBar)
    }
    
    func constraintSubviews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(7)
        }
    }
}

private extension AddCityController.CityHeaderCell {
  
}
