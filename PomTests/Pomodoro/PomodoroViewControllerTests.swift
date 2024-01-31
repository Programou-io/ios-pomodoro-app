import SnapshotTesting
import XCTest

@testable import Pom

final class PomodoroViewControllerTests: XCTestCase {
    func test_onViewDidLoad_shouldConfigureAsFocusMode() {
        let isRecording = false
        let name = "PomodoroViewController"
        let test = "FocusInactive"
        let sut = PomodoroViewController()
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
        let sut = PomodoroViewController()
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
}
