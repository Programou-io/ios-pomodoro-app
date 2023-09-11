import UIKit

extension UIStackView {
    func append(_ views: UIView...) {
        views.forEach(addArrangedSubview)
    }
}
