import Foundation

enum PomodoroPhase: Int {
    case focus = 1500
    case shortBreak = 300
    case longBreak = 900

    var duration: Int {
        rawValue
    }
}
