import XCTest

@testable import Pom

final class PomodoroComposerTests: XCTestCase {
    func test_shouldSetTimerLabel_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(pomodoroViewController.timerLabel.text, "00:25:00")
    }

    func test_shouldSetCycleLabel_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(pomodoroViewController.cycleLabel.text, "0")
    }

    func test_shouldSetPrimaryButtonTitle_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(
            pomodoroViewController.primaryButton.title(for: .normal),
            "iniciar foco"
        )
    }

    func test_shouldSetTimerCircularProgress_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(
            pomodoroViewController.pomodoroTimerCircularProgressIndicatorView.progress,
            0.0
        )
    }

    func test_shouldSetCycleCircularProgress_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(
            pomodoroViewController.pomodoroCycleCircularProgressIndicatorView.progress,
            0.0
        )
    }

    func test_shouldSetCyclePhase_whenViewControllerLoads() {
        let pomodoroViewController = PomodoroComposer.compose()

        pomodoroViewController.loadViewIfNeeded()

        XCTAssertEqual(
            pomodoroViewController.pomodoroCycleCircularProgressIndicatorView.color,
            .focus
        )
        XCTAssertEqual(
            pomodoroViewController.pomodoroTimerCircularProgressIndicatorView.color,
            .focus
        )
        XCTAssertEqual(pomodoroViewController.timerLabel.textColor, .focus)
        XCTAssertEqual(pomodoroViewController.cycleLabel.textColor, .focus)
        XCTAssertEqual(pomodoroViewController.primaryButton.backgroundColor, .focus)
    }
}
