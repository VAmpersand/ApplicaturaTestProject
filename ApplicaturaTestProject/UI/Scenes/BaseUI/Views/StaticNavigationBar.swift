import UIKit

public final class StaticNavigationBar: UIView {
    init(title: String,
         rightButtonImage: UIImage? = nil,
         rightAction: (() -> Void)? = nil) {
        super.init(frame: .zero)

        setupSelf()
        self.title = title
        self.rightAction = rightAction

        if let rightButtonImage = rightButtonImage, let rightAction = rightAction {
            addRightButton(with: rightButtonImage, action: rightAction)
        }
    }

    private var rightAction: (() -> Void)?

    var rightButton: UIButton?

    public var textAligment: NSTextAlignment {
        get {
            return titleLabel.textAlignment
        } set {
            titleLabel.textAlignment = newValue
        }
    }

    public var titleColor: UIColor? {
        didSet {
            titleLabel.textColor = titleColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public var title: String? {
        get {
            return titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)

        return label
    }()
}

public extension StaticNavigationBar {
    func setupSelf() {
        addSubview(titleLabel)

        constraintSubviews()
    }
    
    func addRightButton(with image: UIImage, action: (() -> Void)) {
        let rightButton = UIButton(type: .system)
        rightButton.setImage(image, for: .normal)
        rightButton.tintColor = .black
        rightButton.addTarget(nil, action: #selector(handleRightButton), for: .touchUpInside)

        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(20)
        }
        self.rightButton = rightButton
    }

    @objc func handleRightButton() {
        rightAction?()
    }

    func constraintSubviews() {
        titleLabel.snp.makeConstraints {make in
            make.right.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(27)
        }
    }
}
