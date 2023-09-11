protocol PomodoroDelegate {
    func changeTime(_ time: Int)
    func changePhase(_ phase: PhaseData)
}

final class Pomodoro {
    
    var delegate: PomodoroDelegate?
    
    private let timer: PomodoroTimer
    private let cycle: Cycle
    private(set) var timeSpend = 0 {
        didSet {
            delegate?.changeTime(timeSpend)
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
