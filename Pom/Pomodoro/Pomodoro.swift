protocol PomodoroDelegate {
    func changeTime(_ time: Int)
    func changePhase(_ phase: PhaseData)
}

final class Pomodoro {
    private let timer: PomodoroTimer
    private let cycle: Cycle

    private(set) var timeSpend = 0

    var delegate: PomodoroDelegate?

    init(timer: PomodoroTimer, cycle: Cycle) {
        self.timer = timer
        self.cycle = cycle
    }

    func setTimer() {
        timeSpend = 0
        timer.removeTimer()
        delegate?.changeTime(timeSpend)
        timer.setTimer { [weak self] in
            guard let self else { return }
            timeSpend += 1
            delegate?.changeTime(timeSpend)

            guard let data = cycle.trigger(timeSpend: timeSpend) else {
                return
            }

            timeSpend = 0
            delegate?.changeTime(timeSpend)
            timer.removeTimer()
            delegate?.changePhase(
                PhaseData(
                    phase: data.phase,
                    cycles: data.cycles,
                    pomodoros: data.pomodoros
                )
            )
        }
    }
}
