import UIKit.UIViewController

protocol Scene: class {
    var viewController: UIViewController? { get }
    var router: Router { get }
}
