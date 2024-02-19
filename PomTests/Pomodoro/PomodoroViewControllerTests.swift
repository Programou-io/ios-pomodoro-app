import SnapshotTesting
import XCTest

@testable import Pom

final class PomodoroViewControllerTests: XCTestCase {
    func test_onViewDidLoad_shouldConfigureAsFocusMode() {
        let isRecording = false
        let name = "PomodoroViewController"
        let test = "FocusInactive"
        let sut = PomodoroViewController(viewModel: PomodoroViewModelSpy())
        sut.setTimeProgress(0.95, duration: 0.0)  //1.0 = 100%
        sut.setCycleProgress(0.75, duration: 0.0)  //1.0 = 100%
        sut.setPhase(.focus)
        sut.setButtonTitle("iniciar foco")
        sut.setTime("00:00:00")
        sut.setCycle("3")

        sut.loadViewIfNeeded()

        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)DarkMode"
        )

        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)LightMode"
        )

        let extraLargeTrait = UITraitCollection(
            preferredContentSizeCategory: .extraExtraExtraLarge
        )
        assertSnapshot(
            of: sut,
            as: .image(traits: extraLargeTrait),
            named: name,
            record: isRecording,
            testName: "\(test)3xExtraLarge"
        )
    }

    func test_onViewDidLoad_shouldConfigureAsShortBreakMode_whenPhaseChange() {
        let isRecording = false
        let name = "PomodoroViewControllerShortBreak"
        let test = "FocusInactive"
        let sut = PomodoroViewController(viewModel: PomodoroViewModelSpy())
        sut.setTimeProgress(0.95, duration: 0.0)  //1.0 = 100%
        sut.setCycleProgress(0.75, duration: 0.0)  //1.0 = 100%
        sut.setPhase(.shortBreak)
        sut.setButtonTitle("iniciar foco")
        sut.setTime("00:00:00")
        sut.setCycle("3")

        sut.loadViewIfNeeded()

        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)DarkMode"
        )

        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)LightMode"
        )

        let extraLargeTrait = UITraitCollection(
            preferredContentSizeCategory: .extraExtraExtraLarge
        )
        assertSnapshot(
            of: sut,
            as: .image(traits: extraLargeTrait),
            named: name,
            record: isRecording,
            testName: "\(test)3xExtraLarge"
        )
    }

    func test_onViewDidLoad_shouldConfigureAsLongBreakMode_whenPhaseChange() {
        let isRecording = false
        let name = "PomodoroViewControllerLongBreak"
        let test = "FocusInactive"
        let sut = PomodoroViewController(viewModel: PomodoroViewModelSpy())
        sut.setTimeProgress(0.95, duration: 0.0)  //1.0 = 100%
        sut.setCycleProgress(0.75, duration: 0.0)  //1.0 = 100%
        sut.setPhase(.longBreak)
        sut.setButtonTitle("iniciar foco")
        sut.setTime("00:00:00")
        sut.setCycle("3")

        sut.loadViewIfNeeded()

        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)DarkMode"
        )

        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(
            of: sut,
            as: .image,
            named: name,
            record: isRecording,
            testName: "\(test)LightMode"
        )

        let extraLargeTrait = UITraitCollection(
            preferredContentSizeCategory: .extraExtraExtraLarge
        )
        assertSnapshot(
            of: sut,
            as: .image(traits: extraLargeTrait),
            named: name,
            record: isRecording,
            testName: "\(test)3xExtraLarge"
        )
    }

    func test_primaryButtonDidTapped_shouldCallViewModelToStartCycle() {
        let viewModel = PomodoroViewModelSpy()
        let sut = PomodoroViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()

        XCTAssertEqual(viewModel.startCycleCallCount, 0)

        sut.primaryButton.sendActions(for: .touchUpInside)

        XCTAssertEqual(viewModel.startCycleCallCount, 1)
    }

    func test_viewDidLoad_shouldSetViewModelDelegate() {
        let viewModel = PomodoroViewModelSpy()
        let sut = PomodoroViewController(viewModel: viewModel)

        XCTAssertNil(viewModel.delegate)

        sut.loadViewIfNeeded()

        XCTAssertNotNil(viewModel.delegate)
    }

    private final class PomodoroViewModelSpy: PomodoroViewModeling {

        var delegate: PomodoroViewModelDelegate?

        private(set) var setupInitialStateCallCount = 0
        private(set) var startCycleCallCount = 0

        func setupInitialState() {
            setupInitialStateCallCount += 1
        }

        func startCycle() {
            startCycleCallCount += 1
        }
    }
}
