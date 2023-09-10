import UIKit

final class PomodoroView: UIView {
    var onClick: Bind?
    private lazy var pomodorosLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        label.textAlignment = .center
        return label
    }()
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        label.textAlignment = .center
        label.text = "00:25:00"
        return label
    }()
    private lazy var periodsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primary
        label.textAlignment = .center
        label.text = "0/4"
        return label
    }()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .primary
        btn.setTitle("iniciar ciclo", for: .normal)
        btn.titleLabel?.textColor = .background
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 20
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private lazy var mainVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarcy()
        setupConstraints()
        startButton.addTarget(
            self,
            action: #selector(startButtonActionHandler),
            for: .primaryActionTriggered
        )
    }
    @available(*, unavailable) required init?(coder: NSCoder) { nil }
    func setupSeasonStyle(color: UIColor) {
        timeLabel.textColor = color
        pomodorosLabel.textColor = color
        periodsLabel.textColor = color
        startButton.backgroundColor = color
    }
    func setTime(_ time: String) { timeLabel.text = time }
    func setPeriod(_ period: String) { periodsLabel.text = period }
    func setPomodoros(_ pomodoros: String) { pomodorosLabel.text = pomodoros }
    func setButtonTitle(_ btnTitle: String) {
        startButton.setTitle(btnTitle, for: .normal)
    }
    private func setupHierarcy() {
        mainVerticalStack.addArrangedSubview(pomodorosLabel)
        mainVerticalStack.addArrangedSubview(timeLabel)
        mainVerticalStack.addArrangedSubview(periodsLabel)
        mainVerticalStack.addArrangedSubview(startButton)
        addSubview(mainVerticalStack)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            startButton.heightAnchor.constraint(equalToConstant: 40),
            mainVerticalStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainVerticalStack.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            mainVerticalStack.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
        ])
    }
    @objc private func startButtonActionHandler() { onClick?() }
}
