import UIKit

public enum Icons { }

// MARK: - AddCity
public extension Icons {
    static var close: UIImage {
        image(named: "newsInfo_close")
    }
}

extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
