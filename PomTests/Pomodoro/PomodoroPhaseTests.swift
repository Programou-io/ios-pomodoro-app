import XCTest

@testable import Pom

final class PomodoroPhaseTests: XCTestCase {
    func test_focusDuration_shouldTake25Minutes() {
        XCTAssertEqual(PomodoroPhase.focus.duration, 1500)  //25 minutes
    }

    func test_shortBreakDuration_shouldTake5Minutes() {
        XCTAssertEqual(PomodoroPhase.shortBreak.duration, 300)  // 5 minutes
    }

    func test_longBreakDuration_shouldTake15Minutes() {
        XCTAssertEqual(PomodoroPhase.longBreak.duration, 900)  // 15 minutes
    }
}
