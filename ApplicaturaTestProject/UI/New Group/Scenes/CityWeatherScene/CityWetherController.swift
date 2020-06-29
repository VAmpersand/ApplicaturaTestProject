import UIKit

public final class CityWeatherController: BaseController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    public var viewModel: CityWeatherViewModelProtocol!
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
}

extension CityWeatherController {
    override func setupSelf() {
        super.setupSelf()

        view.backgroundColor = .red
    }
    
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
        closeButton = navigationBarTuple.rightButton
    }
    
    override func addSubviews() {
        super.addSubviews()
        
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
        
    }
}

// MARK: - CityWeatherControllerProtocol
extension CityWeatherController: CityWeatherControllerProtocol {
    public func setCityData(_ cityData: CityData) {
        self.cityData = cityData
    }
}

