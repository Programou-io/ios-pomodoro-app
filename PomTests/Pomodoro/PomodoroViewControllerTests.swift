import SnapshotTesting
import XCTest

@testable import Pom

final class PomodoroViewControllerTests: XCTestCase {
    func test_onViewDidLoad_shouldConfigureAsFocusMode() {
        let isRecording = false
        let sut = PomodoroViewController()
        _ = sut.view

        sut.overrideUserInterfaceStyle = .dark
        assertSnapshot(
            of: sut,
            as: .image,
            named: "PomodoroViewController",
            record: isRecording,
            testName: "FocusInactiveDarkMode"
        )

        sut.overrideUserInterfaceStyle = .light
        assertSnapshot(
            of: sut,
            as: .image,
            named: "PomodoroViewController",
            record: isRecording,
            testName: "FocusInactiveLightMode"
        )

        assertSnapshot(
            of: sut,
            as: .image(
                traits: UITraitCollection(
                    preferredContentSizeCategory: .extraExtraExtraLarge
                )
            ),
            named: "PomodoroViewController",
            record: isRecording,
            testName: "ExtraLargeFocusInactiveLightMode"
        )
    }
}
