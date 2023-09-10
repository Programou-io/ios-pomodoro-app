import Foundation

struct PomodoroPhaseViewData {
    let time: String
    let buttonTitle: String
}
protocol PomodoroViewModeling {
    var onTimeChange: BindWith<String>? { get set }
    var onPhaseChange: BindWith<Stage>? { get set }
    var onDetailsChange: BindWith<PomodoroPhaseViewData>? { get set }
    var periods: String { get }
    var pomodoros: String { get }
    func didStart()
}
class PomodoroViewModel: PomodoroViewModeling {
    private var pomodoro: Pomodoro
    var onTimeChange: BindWith<String>?
    var onPhaseChange: BindWith<Stage>?
    var onDetailsChange: BindWith<PomodoroPhaseViewData>?
    private(set) var periods = String()
    private(set) var pomodoros = String()
    init(pomodoro: Pomodoro) { self.pomodoro = pomodoro }
    func didStart() {
        onDetailsChange?(
            PomodoroPhaseViewData(time: "00:00:00", buttonTitle: "interromper")
        )
        pomodoro.startTimer()
    }
}
extension PomodoroViewModel: PomodoroDelegate {
    func timeDidChange(time: TimeInterval) {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        let format = "%02d:%02d:%02d"
        let timeViewData = String(format: format, hours, minutes, seconds)
        onTimeChange?(timeViewData)
    }
    func seasonDidChange(season: SeasonData) {
        onPhaseChange?(season.season)
        periods = "\(season.cycles)/4"
        pomodoros = String(repeating: "🍅", count: season.pomodoros)
        switch season.season {
        case .focus:
            let vd = PomodoroPhaseViewData(time: "00:25:00", buttonTitle: "iniciar foco")
            onDetailsChange?(vd)
        case .shortBreak:
            let vd = PomodoroPhaseViewData(
                time: "00:05:00",
                buttonTitle: "iniciar pausa curta"
            )
            onDetailsChange?(vd)
        case .longBreak:
            let vd = PomodoroPhaseViewData(
                time: "00:15:00",
                buttonTitle: "iniciar pausa longa"
            )
            onDetailsChange?(vd)
        }
    }
}
