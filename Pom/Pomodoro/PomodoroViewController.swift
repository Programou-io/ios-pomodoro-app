import UIKit

final class PomodoroViewController: UIViewController {
    private var viewModel: PomodoroViewModeling
    private let content = PomodoroView()
    init(viewModel: PomodoroViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable) required init?(coder: NSCoder) { nil }
    override func loadView() { view = content }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        bindView()
        bindViewModel()
    }
    private func bindView() { content.onClick = { self.viewModel.didStart() } }
    private func bindViewModel() {
        viewModel.onPhaseChange = { [weak self] phase in self?.onPhaseHandler(phase) }
        viewModel.onDetailsChange = { [weak self] phaseViewData in
            self?.onDetailHandler(phaseViewData)
        }
        viewModel.onTimeChange = { time in self.content.setTime(time) }
    }
    private func onPhaseHandler(_ phase: Stage) {
        switch phase {
        case .focus: content.setupSeasonStyle(color: .primary)
        case .shortBreak: content.setupSeasonStyle(color: .secondary)
        case .longBreak: content.setupSeasonStyle(color: .tertiary)
        }
    }
    private func onDetailHandler(_ viewData: PomodoroPhaseViewData) {
        content.setPeriod(viewModel.periods)
        content.setPomodoros(viewModel.pomodoros)
        content.setTime(viewData.time)
        content.setButtonTitle(viewData.buttonTitle)
    }
}
