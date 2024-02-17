import Foundation

final class DefaultPomodoroTimer: PomodoroTimer {
    private(set) var timer: Timer?

    func setTimer(execute: @escaping () -> Void) {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true,
            block: { _ in execute() }
        )
        timer?.fire()
    }

    func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
}
