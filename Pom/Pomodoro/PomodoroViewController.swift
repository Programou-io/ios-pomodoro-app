import UIKit

final class PomodoroViewController: UIViewController {

    private lazy var pomodoroTimerCircularProgressIndicatorView =
        CircularProgressIndicator()

    private lazy var pomodoroCycleCircularProgressIndicatorView =
        CircularProgressIndicator(lineWidth: 5)

    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .focus
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    private lazy var cycleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .focus
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .center
        return label
    }()

    private lazy var primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .focus
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.setTitleColor(.background, for: .normal)
        button.layer.cornerRadius = 48 / 2
        return button
    }()

    private lazy var mainVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 30
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewCode()
    }

    func setButtonTitle(_ title: String) {
        primaryButton.setTitle(title, for: .normal)
    }

    func setCycle(_ cycle: String) {
        cycleLabel.text = cycle
    }

    func setTime(_ time: String) {
        timerLabel.text = time
    }

    func setTimeProgress(_ percetage: Double, duration: TimeInterval = 0.5) {
        pomodoroTimerCircularProgressIndicatorView.setProgress(
            percetage,
            duration: duration
        )
    }

    func setCycleProgress(_ percetage: Double, duration: TimeInterval = 0.5) {
        pomodoroCycleCircularProgressIndicatorView.setProgress(
            percetage,
            duration: duration
        )
    }

    func setPhase(_ phase: PomodoroPhase) {
        let phaseColor: UIColor

        switch phase {
        case .focus:
            phaseColor = .focus
        case .shortBreak:
            phaseColor = .shortBreak
        case .longBreak:
            phaseColor = .longBreak
        }

        pomodoroCycleCircularProgressIndicatorView.setColor(phaseColor)
        pomodoroTimerCircularProgressIndicatorView.setColor(phaseColor)
        timerLabel.textColor = phaseColor
        cycleLabel.textColor = phaseColor
        primaryButton.backgroundColor = phaseColor
    }
}

extension PomodoroViewController: ViewCode {

    func configureStyle() {
        view.backgroundColor = .background
    }

    func configureHierarchy() {
        mainVerticalStack.append(
            pomodoroTimerCircularProgressIndicatorView,
            primaryButton
        )
        pomodoroTimerCircularProgressIndicatorView.add(timerLabel)
        pomodoroCycleCircularProgressIndicatorView.add(cycleLabel)
        view.add(pomodoroCycleCircularProgressIndicatorView, mainVerticalStack)
    }

    func configureConstraints() {
        timerLabel.makeConstraint {
            $0.top(reference: pomodoroTimerCircularProgressIndicatorView.top)
            $0.leading(reference: pomodoroTimerCircularProgressIndicatorView.leading)
            $0.trailing(reference: pomodoroTimerCircularProgressIndicatorView.trailing)
            $0.bottom(reference: pomodoroTimerCircularProgressIndicatorView.bottom)
        }
        cycleLabel.makeConstraint {
            $0.top(reference: pomodoroCycleCircularProgressIndicatorView.top)
            $0.leading(reference: pomodoroCycleCircularProgressIndicatorView.leading)
            $0.trailing(reference: pomodoroCycleCircularProgressIndicatorView.trailing)
            $0.bottom(reference: pomodoroCycleCircularProgressIndicatorView.bottom)
        }
        primaryButton.makeConstraint {
            $0.height(48)
        }
        pomodoroTimerCircularProgressIndicatorView.makeConstraint {
            $0.height(230)
        }
        pomodoroCycleCircularProgressIndicatorView.makeConstraint {
            $0.top(reference: view.safeTop, padding: 16)
            $0.trailing(reference: view.trailing, padding: -16)
            $0.height(46)
            $0.width(46)
        }
        mainVerticalStack.makeConstraint {
            $0.width(230)
            $0.centerX(reference: view.centerX)
            $0.centerY(reference: view.centerY)
        }
    }
}
