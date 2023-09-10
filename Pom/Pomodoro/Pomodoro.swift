import Foundation

protocol PomodoroDelegate: AnyObject {
    func timeDidChange(time: TimeInterval)
    func seasonDidChange(season: SeasonData)
}

protocol Time {
    func setInterval(interval: TimeInterval, execute: @escaping Bind)
    func remove()
}

final class TimerAdapter: Time {
    private var timer = Timer()
    func setInterval(interval: TimeInterval, execute: @escaping Bind) {
        timer = Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true,
            block: { [execute] _ in
                execute()
            }
        )
    }
    func remove() {
        timer.invalidate()
    }
}

final class Pomodoro {
    weak var delegate: PomodoroDelegate?

    private var timer: Time
    private var timeSpend = TimeInterval(0)
    private var cycle = Cycle()

    init(timer: Time) {
        self.timer = timer
    }

    func startTimer() {
        timeSpend = 0
        timer.remove()
        let pomodoro = cycle.interrupt()
        let data = SeasonData(
            season: pomodoro.phase,
            cycles: pomodoro.cycles,
            pomodoros: pomodoro.pomodoros
        )
        delegate?.seasonDidChange(season: data)
        timer.setInterval(interval: 1) { [weak self] in
            guard let self else { return }
            timeSpend += 1

            guard let pomodoro = cycle.trigger(timeSpend: timeSpend) else {
                delegate?.timeDidChange(time: timeSpend)
                return
            }

            timeSpend = 0
            timer.remove()
            let data = SeasonData(
                season: pomodoro.phase,
                cycles: pomodoro.cycles,
                pomodoros: pomodoro.pomodoros
            )
            delegate?.seasonDidChange(season: data)
        }
    }
}

struct SeasonData {
    let season: Stage
    let cycles: Int
    let pomodoros: Int
}
