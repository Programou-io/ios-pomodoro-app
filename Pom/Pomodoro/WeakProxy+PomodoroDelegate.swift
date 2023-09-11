extension WeakProxy: PomodoroDelegate where T: PomodoroDelegate {
    func changeTime(_ time: Int) {
        instance?.changeTime(time)
    }

    func changePhase(_ phase: PhaseData) {
        instance?.changePhase(phase)
    }
}
