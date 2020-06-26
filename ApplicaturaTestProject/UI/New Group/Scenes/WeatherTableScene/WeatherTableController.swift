import UIKit

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
    var result: [CityData]?
    
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
        
        let service = JSONDecoderService()
        let path = Bundle.main.path(forResource: "city.list.min", ofType: "json")
    
        do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path ?? ""), options: .mappedIfSafe)
            DispatchQueue.main.async {
                self.result = service.decodeData(fron: data, with: [CityData].self)
            }
        } catch {
            print(error.localizedDescription)
        }
        
                           
//        let navigationBarTuple = addStaticNavigationBar(
//            StaticNavigationBar(title: Texts.NewsInfo.title,
//                                rightButtonImage: Icons.NewsInfo.back,
//                                rightAction: {
//                                    self.viewModel.handleClose()
//            })
//        )
//        navigationBar = navigationBarTuple.navigationBar
//        navigationBar.textAligment = .center
//        closeButton = navigationBarTuple.rightButton
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
        print(result)
    }
    
}

