import UIKit

extension ForcastWeatherController {
    public class WeatherCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: WeatherCell.self)
        private var forcastWeather: ForcastWeather!
        
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

private extension ForcastWeatherController.WeatherCell {
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
extension ForcastWeatherController.WeatherCell: UITableViewDataSource {
    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ForcastWeatherController.ParameterTableCell.cellID,
            for: indexPath
            ) as! ForcastWeatherController.ParameterTableCell
        
        guard let forcastWeather = forcastWeather else { return cell }
        
        switch indexPath.row {
        case 0:
            if let date = forcastWeather.dt_txt.split(separator: " ").first.map(String.init) {
                cell.setupCell(with: "Data", value: date)
            }
        case 1:
            if let time = forcastWeather.dt_txt.split(separator: " ").last.map(String.init) {
                cell.setupCell(with: "Time", value: time)
            }
        case 2:
            cell.setupCell(with: "Temperature:", value: "\((forcastWeather.main.temp - 273).rounded()) C")
        case 3:
            cell.setupCell(with: "Feels like:", value: "\((forcastWeather.main.feels_like - 273).rounded()) C")
        case 4:
            cell.setupCell(with: "Mim temperature", value: "\((forcastWeather.main.temp_min - 273).rounded()) C")
        case 5:
            cell.setupCell(with: "Max temperature", value: "\((forcastWeather.main.temp_max - 273).rounded()) C")
        case 6:
            cell.setupCell(with: "Pressure", value: "\(forcastWeather.main.pressure) hPa")
        case 7:
            if let sea_level = forcastWeather.main.sea_level {
                cell.setupCell(with: "Pressure in\nsea level", value: "\(sea_level) hPa")
            }
        case 8:
            if let grnd_level = forcastWeather.main.grnd_level {
                cell.setupCell(with: "Pressure in\nground level", value: "\(grnd_level) hPa")
            }
        case 9:
            cell.setupCell(with: "Humidity", value: "\(forcastWeather.main.humidity) %")
        case 10:
            cell.setupCell(with: "Wind speed", value: "\(forcastWeather.wind.speed) m/s")
        case 11:
            cell.setupCell(with: "Clouds:", value: "\(forcastWeather.clouds.all) %")
        default:
            break
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ForcastWeatherController.WeatherCell: UITableViewDelegate {
    public func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

public extension ForcastWeatherController.WeatherCell {
    func setupForcastWeather(_ forcastWeather: ForcastWeather) {
        self.forcastWeather = forcastWeather
    }
}

