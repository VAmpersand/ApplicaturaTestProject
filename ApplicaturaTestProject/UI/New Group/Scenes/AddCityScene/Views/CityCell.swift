import UIKit

extension AddCityController {
    public class CityCell: BaseTableCell {
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
    override func addSubviews() {
        super.addSubviews()
        addSubview(cityLabel)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
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
