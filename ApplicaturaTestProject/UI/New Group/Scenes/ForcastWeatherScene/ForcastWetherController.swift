import UIKit

public final class ForecastWeatherController: BaseController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    public var viewModel: ForecastWeatherViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    private var cityData: CityData! {
        didSet {
            guard let city = cityData.name,
                let country = cityData.country else { return }
            navigationBar.title = [Texts.CityWeather.title,
                                   city,
                                   country].joined(separator: " ")
        }
    }
    
    private var forecastWeathers: [CityWeather] = [] {
        didSet {
            weathersCollectionView.reloadData()
        }
    }
    
    private lazy var weathersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(WeatherCell.self,
                                forCellWithReuseIdentifier: WeatherCell.cellID)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
}

extension ForecastWeatherController {
    override func addNavigationBar() {
        super.addNavigationBar()
        let navigationBarTuple = addStaticNavigationBar(
            StaticNavigationBar(title: Texts.CityWeather.title,
                                rightButtonImage: Icons.close,
                                rightAction: { self.viewModel.handleClose() }
            )
        )
        navigationBar = navigationBarTuple.navigationBar
        navigationBar.textAligment = .center
        navigationBar.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        navigationBar.titleColor = .white
        closeButton = navigationBarTuple.rightButton
        closeButton.tintColor = .white
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(weathersCollectionView)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        weathersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
    }
}

// MARK: - ForecastWeatherControllerProtocol
extension ForecastWeatherController: ForecastWeatherControllerProtocol {
    public func setCityData(_ cityData: CityData) {
        self.cityData = cityData
    }
    
    public func setforecastWeathers(_ forecastWeathers: [CityWeather]) {
        self.forecastWeathers = forecastWeathers
    }
}

//MARK:- UICollectionViewDataSource
extension ForecastWeatherController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastWeathers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.cellID,
                                                      for: indexPath) as! WeatherCell
        cell.setupforecastWeather(forecastWeathers[indexPath.row])
        
        return cell
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ForecastWeatherController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height)
    }
}
