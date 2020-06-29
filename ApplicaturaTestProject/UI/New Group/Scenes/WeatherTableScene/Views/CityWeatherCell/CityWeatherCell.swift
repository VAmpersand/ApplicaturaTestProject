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
        
        private var cityWeather: CityWeather! {
            didSet {
                parametersCollectionView.reloadData()
            }
        }
        
        private lazy var cityLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.italicSystemFont(ofSize: 19)
            label.numberOfLines = 0
            
            return label
        }()
        
        private lazy var parametersCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .vertical
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.register(ParameterCell.self,
                                    forCellWithReuseIdentifier: ParameterCell.cellID)
            collectionView.backgroundColor = .clear
            collectionView.isScrollEnabled = false
            collectionView.dataSource = self
            collectionView.delegate = self
            
            return collectionView
        }()
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
        addSubview(parametersCollectionView)
    }
    
    func constraintSubviews() {
        cityLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(15)
        }
        
        parametersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(123)
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
    
    public func setWeatherData(_ cityWeather: CityWeather) {
        self.cityWeather = cityWeather
    }
}

//MARK:- UICollectionViewDataSource
extension WeatherTableController.CityWeatherCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherTableController.ParameterCell.cellID,
            for: indexPath
            ) as! WeatherTableController.ParameterCell
        
        guard let cityWeather = cityWeather else { return cell }
        
        switch indexPath.row {
        case 0:
            cell.setupCell(with: "Temperature:", value: "\(((cityWeather.main.temp ?? 273) - 273).rounded()) C")
        case 1:
            cell.setupCell(with: "Feels like:", value: "\(((cityWeather.main.feels_like ?? 273) - 273).rounded()) C")
        case 2:
            cell.setupCell(with: "Clouds:", value: "\(cityWeather.clouds.all ?? 0) %")
        case 3:
            cell.setupCell(with: "Humidity", value: "\(cityWeather.main.humidity ?? 0) %")
        case 4:
            cell.setupCell(with: "Wind speed", value: "\(cityWeather.wind.speed ?? 0) m/s")
        case 5:
            cell.setupCell(with: "Pressure", value: "\(cityWeather.main.pressure ?? 0) hPa")
        default:
            break
        }
        
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension WeatherTableController.CityWeatherCell: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: 40)
    }
}
