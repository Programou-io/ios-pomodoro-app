protocol PomodoroViewModelDelegate {
    func changeTime(viewData: PomodoroTimeViewData)
    func changeButton(viewData: PomodoroButtonViewData)
    func changePhase(viewData: PomodoroPhaseViewData)
    func changeCycles(viewData: PomodoroCyclesViewData)
    func changePomodoros(viewData: PomodoroDoneViewData)
}

final class PomodoroViewModel {
    var delegate: PomodoroViewModelDelegate?

    private var pomodoro: Pomodorable

    init(pomodoro: Pomodorable) {
        self.pomodoro = pomodoro
    }

    func startCycle() {
        delegate?.changeTime(viewData: PomodoroTimeViewData(time: "00:00:00"))
        delegate?.changeButton(viewData: PomodoroButtonViewData(title: "pausar"))
        pomodoro.setTimer()
    }
}

extension PomodoroViewModel: PomodoroDelegate {
    func changeTime(_ time: Int) {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        let timeFormat = "%02d:%02d:%02d"
        let timeFormatted = String(format: timeFormat, hours, minutes, seconds)
        delegate?.changeTime(viewData: PomodoroTimeViewData(time: timeFormatted))
    }

    func changePhase(_ data: PhaseData) {
        delegate?.changePhase(viewData: PomodoroPhaseViewData(phase: data.phase))
        delegate?.changeCycles(
            viewData: PomodoroCyclesViewData(period: (Double(data.cycles) / 4))
        )
        delegate?.changePomodoros(
            viewData: PomodoroDoneViewData(pomodoros: "\(data.pomodoros)")
        )
        switch data.phase {
        case .focus:
            changeTimeAndButton(time: "00:25:00", buttonTitle: "iniciar foco")
        case .shortBreak:
            changeTimeAndButton(time: "00:05:00", buttonTitle: "iniciar pausa curta")
        case .longBreak:
            changeTimeAndButton(time: "00:15:00", buttonTitle: "iniciar pausa longa")
        }
    }

    private func changeTimeAndButton(time: String, buttonTitle: String) {
        delegate?.changeButton(
            viewData: PomodoroButtonViewData(title: buttonTitle)
        )
        delegate?.changeTime(viewData: PomodoroTimeViewData(time: time))
    }
}
