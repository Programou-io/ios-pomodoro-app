import UIKit

final class CircularProgressIndicator: UIView {
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    private var progress = 0.0

    private let color: UIColor
    private let lineWidth: CGFloat

    private lazy var containerView = UIView()

    init(color: UIColor = .focus, lineWidth: CGFloat = 10.0) {
        self.color = color
        self.lineWidth = lineWidth
        super.init(frame: .zero)
        configureViewCode()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    override func layoutSubviews() {
        super.layoutSubviews()
        createCircularPath()
    }

    func completeProgress(duration: TimeInterval = 0.5) {
        let value = 1.0
        animateProgress(value: value, duration: duration)
    }

    func setProgress(_ value: Double, duration: TimeInterval = 0.5) {
        animateProgress(value: value, duration: duration)
    }

    private func animateProgress(value: Double, duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        progress = value
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(
                x: frame.height / 2,
                y: frame.height / 2
            ),
            radius: frame.height / 2,
            startAngle: startPoint,
            endAngle: endPoint,
            clockwise: true
        )

        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = lineWidth
        circleLayer.strokeEnd = 1.0
        circleLayer.strokeColor = color.withAlphaComponent(0.4).cgColor
        containerView.layer.addSublayer(circleLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color.cgColor
        containerView.layer.addSublayer(progressLayer)
    }
}

extension CircularProgressIndicator: ViewCode {
    func configureHierarchy() {
        add(containerView)
    }

    func configureConstraints() {
        containerView.makeConstraint {
            $0.leading(reference: leading)
            $0.top(reference: top)
        }

        makeConstraint {
            $0.trailing(reference: containerView.trailing)
            $0.bottom(reference: containerView.bottom)
        }
    }
}
