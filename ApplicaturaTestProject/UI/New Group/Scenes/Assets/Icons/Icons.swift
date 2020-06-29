import UIKit

public enum Icons { }

// MARK: - AddCity
public extension Icons {
    enum AddCity {
        static var close: UIImage {
            image(named: "newsInfo_close")
        }
    }
}
extension Icons {
    static func image(named name: String) -> UIImage {
        UIImage(named: name) ?? UIImage()
    }
}
