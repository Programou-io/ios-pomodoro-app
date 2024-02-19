protocol PomodoroTimer {
    func setTimer(execute: @escaping () -> Void)
    func removeTimer()
}
