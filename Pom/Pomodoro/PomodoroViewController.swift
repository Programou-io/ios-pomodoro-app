import UIKit

extension UIColor {
    static var focus: UIColor {
        UIColor(named: "FocusColor")!
    }

    static var shortBreak: UIColor {
        UIColor(named: "ShortBreakColor")!
    }

    static var longBreak: UIColor {
        UIColor(named: "LongBreakColor")!
    }

    static var background: UIColor {
        UIColor(named: "background")!
    }
}

extension UIView {
    func enableViewCode() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

final class PomodoroViewController: UIViewController {

    private lazy var circularProgressContainerView: UIView = {
        let view = UIView()
        view.enableViewCode()
        return view
    }()

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .focus
        label.text = "00:25:00"
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        label.enableViewCode()
        return label
    }()

    private lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .focus
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitle("iniciar foco", for: .normal)
        button.setTitleColor(.background, for: .normal)
        button.layer.cornerRadius = 48 / 2
        button.enableViewCode()
        return button
    }()

    private lazy var mainVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        stack.enableViewCode()
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background

        mainVerticalStack.addArrangedSubview(circularProgressContainerView)
        mainVerticalStack.addArrangedSubview(primaryButton)
        circularProgressContainerView.addSubview(timerLabel)
        view.addSubview(mainVerticalStack)

        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(
                equalTo: circularProgressContainerView.topAnchor,
                constant: 12
            ),
            timerLabel.leadingAnchor.constraint(
                equalTo: circularProgressContainerView.leadingAnchor,
                constant: 12
            ),
            timerLabel.trailingAnchor.constraint(
                equalTo: circularProgressContainerView.trailingAnchor,
                constant: -12
            ),
            timerLabel.bottomAnchor.constraint(
                equalTo: circularProgressContainerView.bottomAnchor,
                constant: -12
            ),

            primaryButton.heightAnchor.constraint(equalToConstant: 48),
            circularProgressContainerView.heightAnchor.constraint(equalToConstant: 230),
            mainVerticalStack.widthAnchor.constraint(equalToConstant: 230),
            mainVerticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainVerticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
