import XCTest

@testable import Pom

final class DefaultPomodoroTimerTests: XCTestCase {
    func test_onInit_shouldSetTimerPropertyAsNil() {
        let sut = DefaultPomodoroTimer()

        XCTAssertNil(sut.timer)
    }

    func test_shouldInitializeTimer_whenSetTimerIsCalled() {
        let sut = DefaultPomodoroTimer()

        sut.setTimer(execute: {})

        XCTAssertNotNil(sut.timer)
    }

    func test_shouldSetTimeIntervalWithOneSecont_whenSetTimerIsCalled() {
        let sut = DefaultPomodoroTimer()

        sut.setTimer(execute: {})

        XCTAssertEqual(sut.timer?.timeInterval, 1.0)
    }

    func test_shouldExecuteSetTimerBlockEachSecond_whenTimerFired() {
        let waitSeconds: TimeInterval = 3
        let sut = DefaultPomodoroTimer()
        trackMemmoryLeak(sut)

        var setTimerExecutionCallbackCallCount = 0
        sut.setTimer {
            setTimerExecutionCallbackCallCount += 1
        }

        let expectation = expectation(description: "waiting some seconds")
        expectation.isInverted = true
        wait(for: [expectation], timeout: waitSeconds)

        XCTAssertEqual(setTimerExecutionCallbackCallCount, Int(waitSeconds), accuracy: 1)
    }

    func test_shouldFreePropertyTimer_whenRemoveTimerWasCalled() {
        let sut = DefaultPomodoroTimer()
        sut.setTimer(execute: {})

        sut.removeTimer()

        XCTAssertNil(sut.timer)
    }

    func test_shouldInvalidateTimer_whenRemoveTimerWasCalled() throws {
        let sut = DefaultPomodoroTimer()
        sut.setTimer(execute: {})
        let timer = sut.timer

        sut.removeTimer()

        XCTAssertFalse(try XCTUnwrap(timer?.isValid))
    }
}
