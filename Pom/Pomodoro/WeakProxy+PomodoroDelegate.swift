extension WeakProxy: PomodoroDelegate where T: PomodoroDelegate {
    func changeTime(_ time: Int, phase: PomodoroPhase) {
        instance?.changeTime(time, phase: phase)
    }

    func changePhase(_ phase: PhaseData) {
        instance?.changePhase(phase)
    }
}
