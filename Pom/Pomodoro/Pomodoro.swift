import Foundation

protocol PomodoroDelegate: AnyObject {
    func timeDidChange(time: TimeInterval)
    func seasonDidChange(season: Stage)
}

final class Pomodoro {
    private(set) var pomodoros = 0
    private(set) var cycles = 0
    private lazy var cycle = makeFocusCycle()
    weak var delegate: PomodoroDelegate?
    func startTimer() {
        cycle.setTimer { [weak delegate] time in delegate?.timeDidChange(time: time) }
    }
    private func makeFocusCycle() -> Cycle {
        Cycle(
            duration: 10, onCancel: { [weak self] in self?.didFinish() },
            onFinish: { [weak self] in self?.didFinish() })
    }
    private func makeShortBreakCycle() -> Cycle {
        Cycle(
            duration: 5,
            onCancel: { [weak self] in guard let self else { return }
                cycles += 1
                self.setSeason(.focus)
            },
            onFinish: { [weak self] in guard let self else { return }
                cycles += 1
                self.setSeason(.focus)
            })
    }
    private func makeLongBreakCycle() -> Cycle {
        Cycle(
            duration: 8,
            onCancel: { [weak self] in guard let self else { return }
                pomodoros += 1
                cycles = 0
                setSeason(.focus)
            },
            onFinish: { [weak self] in guard let self else { return }
                pomodoros += 1
                cycles = 0
                setSeason(.focus)
            })
    }
    private func didFinish() {
        if cycles > 3 { setSeason(.longBreak) } else { setSeason(.shortBreak) }
    }
    private func setSeason(_ season: Stage) {
        setCycle(by: season)
        delegate?.seasonDidChange(season: season)
    }
    private func setCycle(by season: Stage) {
        switch season {
        case .focus: cycle = makeFocusCycle()
        case .shortBreak: cycle = makeShortBreakCycle()
        case .longBreak: cycle = makeLongBreakCycle()
        }
    }
}
