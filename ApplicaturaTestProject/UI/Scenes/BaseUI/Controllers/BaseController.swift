import UIKit
import SnapKit

public class BaseController: UIViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()

        setupSelf()
    }
}

extension BaseController {
    @objc func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        view.backgroundColor = .white
    }
    
    @objc func addSubviews() {
    }
    
    @objc func constraintSubviews() {
    }
}

extension BaseController {
    @discardableResult
    func addStaticNavigationBar(_ bar: StaticNavigationBar) -> (
        navigationBar: StaticNavigationBar,
        rightButton: UIButton?
        ) {
            view.addSubview(bar)
            
            bar.snp.makeConstraints { make in
                make.right.left.equalToSuperview()
                make.top.equalTo(view.safeAreaLayoutGuide)
            }
            
            return (bar, bar.rightButton)
    }
}
