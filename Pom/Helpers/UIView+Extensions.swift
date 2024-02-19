import UIKit

extension UIView {
    func enableViewCode() {
        guard translatesAutoresizingMaskIntoConstraints else {
            return
        }
        translatesAutoresizingMaskIntoConstraints = false
    }

    func add(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }

    var top: NSLayoutYAxisAnchor {
        topAnchor
    }

    var safeTop: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.topAnchor
    }

    var leading: NSLayoutXAxisAnchor {
        leadingAnchor
    }

    var safeLeading: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.leadingAnchor
    }

    var trailing: NSLayoutXAxisAnchor {
        trailingAnchor
    }

    var safeTrailing: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.trailingAnchor
    }

    var bottom: NSLayoutYAxisAnchor {
        bottomAnchor
    }

    var safeBottom: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.bottomAnchor
    }

    var centerX: NSLayoutXAxisAnchor {
        centerXAnchor
    }

    var safeCenterX: NSLayoutXAxisAnchor {
        safeAreaLayoutGuide.centerXAnchor
    }

    var centerY: NSLayoutYAxisAnchor {
        centerYAnchor
    }

    var safeCenterY: NSLayoutYAxisAnchor {
        safeAreaLayoutGuide.centerYAnchor
    }

    var width: NSLayoutDimension {
        widthAnchor
    }

    var safeWidth: NSLayoutDimension {
        safeAreaLayoutGuide.widthAnchor
    }

    var height: NSLayoutDimension {
        heightAnchor
    }

    var safeHeight: NSLayoutDimension {
        safeAreaLayoutGuide.widthAnchor
    }

    func makeConstraint(_ constraintable: (Constraintable) -> Void) {
        constraintable(Constraintable(support: self))
    }

    struct Constraintable {
        private let support: UIView

        init(support: UIView) {
            self.support = support
            self.support.enableViewCode()
        }

        func top(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.top, at: reference, with: padding)
        }

        func bottom(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.bottom, at: reference, with: padding)
        }

        func leading(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.leading, at: reference, with: padding)
        }

        func leading(
            greater reference: NSLayoutXAxisAnchor,
            padding: CGFloat = .zero
        ) {
            active(
                support.leadingAnchor.constraint(
                    greaterThanOrEqualTo: reference,
                    constant: padding
                )
            )
        }

        func leading(
            smaller reference: NSLayoutXAxisAnchor,
            padding: CGFloat = .zero
        ) {
            active(
                support.leadingAnchor.constraint(
                    lessThanOrEqualTo: reference,
                    constant: padding
                )
            )
        }

        func trailing(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.trailing, at: reference, with: padding)
        }

        func trailing(
            greater reference: NSLayoutXAxisAnchor,
            padding: CGFloat = .zero
        ) {
            active(
                support.trailingAnchor.constraint(
                    greaterThanOrEqualTo: reference,
                    constant: padding
                )
            )
        }

        func trailing(
            smaller reference: NSLayoutXAxisAnchor,
            padding: CGFloat = .zero
        ) {
            active(
                support.trailingAnchor.constraint(
                    lessThanOrEqualTo: reference,
                    constant: padding
                )
            )
        }

        func centerX(reference: NSLayoutXAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.centerX, at: reference, with: padding)
        }

        func centerY(reference: NSLayoutYAxisAnchor, padding: CGFloat = .zero) {
            apply(in: support.centerY, at: reference, with: padding)
        }

        func height(_ value: CGFloat) {
            apply(in: support.height, with: value)
        }

        func width(_ value: CGFloat) {
            apply(in: support.width, with: value)
        }

        func size(_ size: CGSize) {
            height(size.height)
            width(size.width)
        }

        func width(smaller reference: NSLayoutDimension) {
            active(support.width.constraint(lessThanOrEqualTo: reference))
        }

        func width(greater reference: NSLayoutDimension) {
            active(support.width.constraint(greaterThanOrEqualTo: reference))
        }

        func size(_ size: CGFloat) {
            height(size)
            width(size)
        }

        func equal(to view: UIView) {
            top(reference: view.top)
            leading(reference: view.leading)
            trailing(reference: view.trailing)
            bottom(reference: view.bottom)
        }

        func safeEqual(to view: UIView) {
            top(reference: view.safeTop)
            leading(reference: view.safeLeading)
            trailing(reference: view.safeTrailing)
            bottom(reference: view.safeBottom)
        }

        private func active(_ constraint: NSLayoutConstraint) {
            constraint.isActive = true
        }

        private func apply(
            in item: NSLayoutYAxisAnchor,
            at reference: NSLayoutYAxisAnchor,
            with padding: CGFloat
        ) { active(item.constraint(equalTo: reference, constant: padding)) }

        private func apply(
            in item: NSLayoutXAxisAnchor,
            at reference: NSLayoutXAxisAnchor,
            with padding: CGFloat
        ) { active(item.constraint(equalTo: reference, constant: padding)) }

        private func apply(in item: NSLayoutDimension, with size: CGFloat) {
            active(item.constraint(equalToConstant: size))
        }
    }
}
