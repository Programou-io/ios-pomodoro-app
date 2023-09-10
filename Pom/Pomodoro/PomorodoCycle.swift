class PomorodoCycle {
    private var phase: PomodoroPhase = .focus
    private var cycles = 0
    private var pomodoros = 0

    func trigger(timeSpend: Double) -> Pomodoro? {
        let isFinished = timeSpend >= phase.duration
        guard isFinished else { return nil }
        phaseHandler()
        return Pomodoro(phase: phase, cycles: cycles, pomodoros: pomodoros)
    }

    private func phaseHandler() {
        switch phase {
        case .focus:
            onFocusHandler()
        case .shortBreak:
            onShortBreakHandler()
        case .longBreak:
            onLongBreakHandler()
        }
    }

    private func onFocusHandler() {
        if cycles < 3 {
            phase = .shortBreak
        } else {
            phase = .longBreak
        }
    }

    private func onShortBreakHandler() {
        phase = .focus
        cycles += 1
    }

    private func onLongBreakHandler() {
        phase = .focus
        cycles = 0
        pomodoros += 1
    }
}
