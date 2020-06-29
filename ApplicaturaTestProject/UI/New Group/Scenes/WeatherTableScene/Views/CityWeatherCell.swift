import UIKit

extension WeatherTableController {
    public class CityWeatherCell: UITableViewCell {
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: CityWeatherCell.self)
        
        private lazy var cityLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.italicSystemFont(ofSize: 19)
            label.numberOfLines = 0
            
            return label
        }()
        
//        private lazy var dateLabel: UILabel = {
//            let label = UILabel()
//            label.textAlignment = .left
//            label.font = UIFont.systemFont(ofSize: 12)
//
//            return label
//        }()
//
//        private lazy var stackView: UIStackView = {
//            let stackView = UIStackView()
//            stackView.distribution = .fill
//            stackView.spacing = 2
//            stackView.axis = .vertical
//            [
//                title,
//                dateLabel,
//            ].forEach(stackView.addArrangedSubview)
//
//            return stackView
//        }()
    }
}

extension WeatherTableController.CityWeatherCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        selectionStyle = .none
    }
    
    func addSubviews() {
        addSubview(cityLabel)
    }
    
    func constraintSubviews() {
        cityLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
        }
    }
}

extension WeatherTableController.CityWeatherCell {
    public func setCityLabel(_ cityData: CityData) {
        guard let city = cityData.name,
            let state = cityData.state,
            let country = cityData.country else { return }
        
        cityLabel.text = state.isEmpty ? [country, city].joined(separator: " ") :
            [country, state, city].joined(separator: " ")
    }
}
