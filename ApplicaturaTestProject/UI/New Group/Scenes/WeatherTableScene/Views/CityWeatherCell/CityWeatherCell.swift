import UIKit

extension WeatherTableController {
    public class CityWeatherCell: BaseTableCell {
        public static let cellID = String(describing: CityWeatherCell.self)
        
        private var presentedCity: PresentedCity! {
            didSet {
                cityLabel.text = presentedCity.name ?? "Weather in your area"
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
    override func addSubviews() {
        super.addSubviews()
        addSubview(cityLabel)
        addSubview(parametersCollectionView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
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
    public func setPresentedCityData(_ presentedCity: PresentedCity) {
        self.presentedCity = presentedCity
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
        
        guard let presentedCity = presentedCity,
            let cityWeather = presentedCity.cityWeather else { return cell }
        
        switch indexPath.row {
        case 0:
            cell.setupCell(with: "Temperature:", value: "\(((cityWeather.temp ?? 273) - 273).rounded()) C")
        case 1:
            cell.setupCell(with: "Feels like:", value: "\(((cityWeather.feelsLike ?? 273) - 273).rounded()) C")
        case 2:
            cell.setupCell(with: "Clouds:", value: "\(cityWeather.clouds ?? 0) %")
        case 3:
            cell.setupCell(with: "Humidity", value: "\(cityWeather.humidity ?? 0) %")
        case 4:
            cell.setupCell(with: "Wind speed", value: "\(cityWeather.windSpeed ?? 0) m/s")
        case 5:
            cell.setupCell(with: "Pressure", value: "\(cityWeather.pressure ?? 0) hPa")
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
