import Foundation

enum PomodoroPhase: Int {
    case focus = 5  //1500
    case shortBreak = 3  //300
    case longBreak = 7  //900

    var duration: Int {
        rawValue
    }
}
