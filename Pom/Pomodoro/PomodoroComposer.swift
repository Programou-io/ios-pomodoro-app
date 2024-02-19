enum PomodoroComposer {
    static func compose() -> PomodoroViewController {
        let pomodoroTimer = DefaultPomodoroTimer()
        let pomodoroCycle = PomorodoCycle()
        let pomodoro = Pomodoro(timer: pomodoroTimer, cycle: pomodoroCycle)
        let pomodoroViewModel = PomodoroViewModel(pomodoro: pomodoro)
        return PomodoroViewController(viewModel: pomodoroViewModel)
    }
}
