import SnapshotTesting
import XCTest

@testable import Pom

final class PomodoroViewControllerTests: XCTestCase {
    func test() {
        let named = "PomodoroViewController"
        let styleMode = "Light"
        let viewModel = PomodoroViewModelStub()
        let sut = PomodoroViewController(viewModel: viewModel)
        let recording = false
        _ = sut.view
        viewModel.periods = "1/4"
        viewModel.pomodoros = "🍅"
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "Default\(styleMode)"
        )
        viewModel.onPhaseChange?(.focus)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "Focus\(styleMode)"
        )
        viewModel.onPhaseChange?(.focus)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "LongBreak\(styleMode)"
        )
        viewModel.onPhaseChange?(.shortBreak)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "ShortBreak\(styleMode)"
        )
    }
    func test2() {
        let named = "PomodoroViewController"
        let styleMode = "Dark"
        let viewModel = PomodoroViewModelStub()
        let sut = PomodoroViewController(viewModel: viewModel)
        let recording = false
        sut.overrideUserInterfaceStyle = .dark
        _ = sut.view
        viewModel.periods = "1/4"
        viewModel.pomodoros = "🍅"
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "Default\(styleMode)"
        )
        viewModel.onPhaseChange?(.focus)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "Focus\(styleMode)"
        )
        viewModel.onPhaseChange?(.focus)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "LongBreak\(styleMode)"
        )
        viewModel.onPhaseChange?(.shortBreak)
        viewModel.onDetailsChange?(
            .init(time: "Any time", buttonTitle: "any button title")
        )
        assertSnapshot(
            of: sut,
            as: .image,
            named: named,
            record: recording,
            testName: "ShortBreak\(styleMode)"
        )
    }
    private class PomodoroViewModelStub: PomodoroViewModeling {
        var onPhaseChange: BindWith<Stage>?
        var onDetailsChange: BindWith<PomodoroPhaseViewData>?
        var onTimeChange: BindWith<String>?
        var periods = String()
        var pomodoros = String()
        func didStart() {}
    }
}
