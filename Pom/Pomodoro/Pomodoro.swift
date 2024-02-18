protocol Pomodorable {
    var delegate: PomodoroDelegate? { get set }
    func setTimer()
}

protocol PomodoroDelegate {
    func changeTime(_ time: Int, phase: PomodoroPhase)
    func changePhase(_ phase: PhaseData)
}

final class Pomodoro: Pomodorable {

    var delegate: PomodoroDelegate?

    private let timer: PomodoroTimer
    private let cycle: Cycle
    private(set) var timeSpend = 0 {
        didSet {
            delegate?.changeTime(timeSpend, phase: cycle.phase)
        }
    }

    init(timer: PomodoroTimer, cycle: Cycle) {
        self.timer = timer
        self.cycle = cycle
    }

    func setTimer() {
        resetTimer()
        timer.setTimer { [weak self] in
            guard let self else { return }
            timerFire()
        }
    }

    private func timerFire() {
        spendTime()

        guard let data = cycle.trigger(timeSpend: timeSpend) else {
            return
        }

        resetTimer()
        changePhase(data: data)
    }

    private func resetTimer() {
        timeSpend = 0
        timer.removeTimer()
    }

    private func spendTime() {
        timeSpend += 1
    }

    private func changePhase(data: PomodoroData) {
        let phaseData = PhaseData(
            phase: data.phase,
            cycles: data.cycles,
            pomodoros: data.pomodoros
        )
        delegate?.changePhase(phaseData)
    }
}
