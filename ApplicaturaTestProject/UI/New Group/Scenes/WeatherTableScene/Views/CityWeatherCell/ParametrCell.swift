import UIKit

extension WeatherTableController {
    public class ParameterCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupSelf()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public static let cellID = String(describing: ParameterCell.self)
        
        public lazy var parameterLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.boldSystemFont(ofSize: 14)
            
            return label
        }()
        
        public lazy var valueLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.systemFont(ofSize: 14)
            
            return label
        }()
    }
}

private extension WeatherTableController.ParameterCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
    }
    
    func addSubviews() {
        addSubview(parameterLabel)
        addSubview(valueLabel)
    }
    
    func constraintSubviews() {
        parameterLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.equalTo(parameterLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
    }
}

extension WeatherTableController.ParameterCell {
    func setupCell(with paramerter: String, value: String) {
        parameterLabel.text = paramerter
        valueLabel.text = value
    }
}
