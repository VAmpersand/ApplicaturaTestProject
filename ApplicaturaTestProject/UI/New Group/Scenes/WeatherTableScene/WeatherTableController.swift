import UIKit

public final class WeatherTableController: BaseController {
    public var viewModel: WeatherTableViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
}

extension WeatherTableController {
    override func setupSelf() {
        super.setupSelf()
        
        view.backgroundColor = .red
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

    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
  
    }
}

// MARK: - WeatherTableControllerProtocol
extension WeatherTableController: WeatherTableControllerProtocol {

    
}

