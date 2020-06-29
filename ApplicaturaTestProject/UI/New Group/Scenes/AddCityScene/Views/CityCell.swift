import UIKit

extension AddCityController {
    public class CityCell: UITableViewCell {
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: CityCell.self)
        
        private lazy var cityLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.italicSystemFont(ofSize: 19)
            label.numberOfLines = 0
            
            return label
        }()
    }
}

extension AddCityController.CityCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }
    
    func addSubviews() {
        addSubview(cityLabel)
    }
    
    func constraintSubviews() {
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(15)
        }
    }
}

extension AddCityController.CityCell {
    public func setCityLabel(_ cityData: CityData) {
        guard let city = cityData.name,
            let state = cityData.state,
            let country = cityData.country else { return }
        
        cityLabel.text = state.isEmpty ? [country, city].joined(separator: " ") :
            [country, state, city].joined(separator: " ")
    }
}
