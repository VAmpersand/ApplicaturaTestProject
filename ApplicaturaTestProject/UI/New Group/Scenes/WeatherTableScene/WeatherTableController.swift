import UIKit

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
//    var result: [CityData]?
    
    private var printButton: UIButton = {
        let button = UIButton()
        button.addTarget(self,
                         action: #selector(buttonPressed),
                         for: .touchUpInside)
        button.backgroundColor = .green
        
        return button
    }()
    
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        
        view.backgroundColor = .red
        
    }
    
    override func addSubviews() {
        super.addSubviews()

        view.addSubview(printButton)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
  
        printButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
    }
}

// MARK: - WeatherTableControllerProtocol
extension WeatherTableController: WeatherTableControllerProtocol {
    @objc func buttonPressed() {
        
    }
    
}

