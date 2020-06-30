import UIKit

extension ForecastWeatherController {
    public class WeatherCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: WeatherCell.self)
        private var forecastWeather: CityWeatherApi!
        
        public lazy var parameterTableView: UITableView = {
            let table = UITableView()
            table.register(ParameterTableCell.self,
                           forCellReuseIdentifier: ParameterTableCell.cellID)
            table.delegate = self
            table.dataSource = self
            table.showsVerticalScrollIndicator = false
            table.separatorStyle = .none
            table.backgroundColor = .clear
            
            return table
        }()
    }
}

private extension ForecastWeatherController.WeatherCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).withAlphaComponent(0.1)
        layer.cornerRadius = 15
    }
    
    func addSubviews() {
        addSubview(parameterTableView)
    }
    
    func constraintSubviews() {
        parameterTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension ForecastWeatherController.WeatherCell: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ForecastWeatherController.ParameterTableCell.cellID,
            for: indexPath
            ) as! ForecastWeatherController.ParameterTableCell
        
        guard let forecastWeather = forecastWeather else { return cell }
        
        switch indexPath.row {
        case 0:
            if let dataStr = forecastWeather.date,
                let date = dataStr.split(separator: " ").first.map(String.init) {
                cell.setupCell(with: "Date", value: date)
            }
        case 1:
            if let dataStr = forecastWeather.date,
                let time = dataStr.split(separator: " ").last.map(String.init) {
                cell.setupCell(with: "Time", value: time)
            }
        case 2:
            cell.setupCell(with: "Temperature:", value: "\(((forecastWeather.main.temp ?? 273) - 273).rounded()) C")
        case 3:
            cell.setupCell(with: "Feels like:", value: "\(((forecastWeather.main.feelsLike ?? 273) - 273).rounded()) C")
        case 4:
            cell.setupCell(with: "Mim temperature", value: "\(((forecastWeather.main.tempMin ?? 273) - 273).rounded()) C")
        case 5:
            cell.setupCell(with: "Max temperature", value: "\(((forecastWeather.main.tempMax ?? 273) - 273).rounded()) C")
        case 6:
            cell.setupCell(with: "Pressure", value: "\(forecastWeather.main.pressure ?? 0) hPa")
        case 7:
            cell.setupCell(with: "Pressure in\nsea level", value: "\(forecastWeather.main.seaLevel ?? 0)  hPa")
        case 8:
            cell.setupCell(with: "Pressure in\nground level", value: "\(forecastWeather.main.grndLevel ?? 0) hPa")
        case 9:
            cell.setupCell(with: "Humidity", value: "\(forecastWeather.main.humidity ?? 0) %")
        case 10:
            cell.setupCell(with: "Wind speed", value: "\(forecastWeather.wind.speed ?? 0) m/s")
        case 11:
            cell.setupCell(with: "Clouds:", value: "\(forecastWeather.clouds.all ?? 0) %")
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ForecastWeatherController.WeatherCell: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

public extension ForecastWeatherController.WeatherCell {
    func setupforecastWeather(_ forecastWeather: CityWeatherApi) {
        self.forecastWeather = forecastWeather
    }
}

