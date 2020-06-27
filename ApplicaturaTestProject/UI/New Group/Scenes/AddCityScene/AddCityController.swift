import UIKit

public final class AddCityController: BaseController {
    public var viewModel: AddCityViewModelProtocol!
    private var navigationBar: StaticNavigationBar!
    private var closeButton: UIButton!
    
}

extension AddCityController {
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

// MARK: - AddCityControllerProtocol
extension AddCityController: AddCityControllerProtocol {

    
}

