import UIKit

extension WeatherTableController {
    public class WeatherHeaderCell: UITableViewHeaderFooterView {
        override public init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        weak var delegate: WeatherHeaderCellDelegate?
        public static let cellID = String(describing: WeatherHeaderCell.self)
        
        private lazy var containerView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
            
            return view
        }()
        
        private lazy var addButton: UIButton = {
            let button = UIButton()
            button.setTitle(Texts.WeatherTable.addButton, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            if UserDefaults.cityDataWasSetup {
                button.isHidden = false
            } else {
                button.isHidden = true
            }
            button.addTarget(self,
                             action: #selector(buttonPressed),
                             for: .touchUpInside)
            
            return button
        }()
        
        private lazy var actyvityIndicator: UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView()
            indicator.hidesWhenStopped = true
            indicator.color = .white
            if UserDefaults.cityDataWasSetup {
                indicator.stopAnimating()
            } else {
                indicator.startAnimating()
            }
            
            return indicator
        }()
    }
}

extension WeatherTableController.WeatherHeaderCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        addObserver()
    }
    
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(addButton)
        containerView.addSubview(actyvityIndicator)
    }
    
    func constraintSubviews() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        actyvityIndicator.snp.makeConstraints { make in
            make.center.equalTo(addButton)
        }
    }
}

private extension WeatherTableController.WeatherHeaderCell {
    @objc func buttonPressed() {
        delegate?.addButtonPressed()
        
        print(LocationService.shared.getUserLocation())
    }
}

private extension WeatherTableController.WeatherHeaderCell {
    func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateView),
                                               name: .cityDataWasSetup,
                                               object: nil)
    }
    
    @objc func updateView() {
        actyvityIndicator.stopAnimating()
        addButton.isHidden = false
    }
}
