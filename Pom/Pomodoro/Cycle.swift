import Foundation

enum Stage: Int {
    case focus = 10
    case shortBreak = 5
    case longBreak = 8

    var duration: TimeInterval {
        TimeInterval(rawValue)
    }
}

struct Pomo {
    let cycles: Int
    let pomodoros: Int
    let phase: Stage
}

class Cycle {
    private var pomodoros = 0
    private var cycles = 0
    private var phase: Stage = .focus

    func trigger(timeSpend: Double) -> Pomo? {
        let isFinished = timeSpend >= phase.duration
        guard isFinished else {
            return nil
        }

        switch phase {
        case .focus:
            if cycles <= 3 {
                phase = .shortBreak
            } else {
                phase = .longBreak
            }
        case .shortBreak:
            cycles += 1
            phase = .focus
        case .longBreak:
            pomodoros += 1
            cycles = 0
            phase = .focus
        }

        return makePomodoro()
    }

    func interrupt() -> Pomo {
        switch phase {
        case .focus:
            if cycles <= 3 {
                phase = .shortBreak
            } else {
                phase = .longBreak
            }
        case .shortBreak:
            cycles += 1
            phase = .focus
        case .longBreak:
            pomodoros += 1
            cycles = 0
            phase = .focus
        }

        return makePomodoro()
    }

    private func makePomodoro() -> Pomo {
        Pomo(cycles: cycles, pomodoros: pomodoros, phase: phase)
    }
}
