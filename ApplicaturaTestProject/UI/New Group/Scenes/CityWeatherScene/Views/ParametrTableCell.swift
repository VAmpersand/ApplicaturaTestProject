import UIKit

extension CityWeatherController {
    public class ParameterTableCell: UITableViewCell {
        
        override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            setupSelf()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
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

private extension CityWeatherController.ParameterTableCell {
    func setupSelf() {
        addSubviews()
        constraintSubviews()
        
        backgroundColor = .clear
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

extension CityWeatherController.ParameterTableCell {
    func setupCell(with paramerter: String, value: String) {
        parameterLabel.text = paramerter
        valueLabel.text = value
    }
}
