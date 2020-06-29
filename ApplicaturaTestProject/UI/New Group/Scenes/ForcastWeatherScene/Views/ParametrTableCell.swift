import UIKit

extension ForecastWeatherController {
    public class ParameterTableCell: BaseTableCell {
        public static let cellID = String(describing: ParameterTableCell.self)
        
        public lazy var parameterLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.numberOfLines = 2
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

extension ForecastWeatherController.ParameterTableCell {
    override func setupSelf() {
        super.setupSelf()
        
        backgroundColor = .clear
    }
    
    override func addSubviews() {
        super.addSubviews()
        addSubview(parameterLabel)
        addSubview(valueLabel)
    }
    
    override func constraintSubviews() {
        super.constraintSubviews()
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

extension ForecastWeatherController.ParameterTableCell {
    func setupCell(with paramerter: String, value: String) {
        parameterLabel.text = paramerter
        valueLabel.text = value
    }
}
