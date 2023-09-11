import XCTest

@testable import Pom

final class PomodoroTests: XCTestCase {
    func test_setTimer_shouldSetupTimerOnce() {
        let env = makeEnviroment()

        env.sut.setTimer()

        XCTAssertEqual(env.timer.setTimerRecieved.count, 1)
    }

    func test_setTimerTwice_shouldSetupTimerTwice() {
        let env = makeEnviroment()

        env.sut.setTimer()
        env.sut.setTimer()

        XCTAssertEqual(env.timer.setTimerRecieved.count, 2)
    }

    func test_setTimer_shouldRemovePrevioulyTimerSetted() {
        let env = makeEnviroment()

        env.sut.setTimer()

        XCTAssertEqual(env.timer.removeTimerCallCount, 1)
    }

    func test_setTimer_shouldSetTimeSpendEqualZero() {
        let env = makeEnviroment()

        env.sut.setTimer()

        XCTAssertEqual(env.sut.timeSpend, 0)
    }

    func test_setTimer_shouldNotifyTheTimeChangesWithZero() {
        let env = makeEnviroment()

        env.sut.setTimer()

        XCTAssertEqual(env.delegate.changeTimeReceived, [0])
    }

    func test_setTimer_shouldIncrementToOne_whenTimerTriggersOnce() {
        let env = makeEnviroment()

        env.sut.setTimer()
        env.timer.trigger()

        XCTAssertEqual(env.sut.timeSpend, 1)
    }

    func test_setTimer_shouldIncrementTo4_whenTimerTriggers4Times() {
        let env = makeEnviroment()

        env.sut.setTimer()
        env.timer.trigger()
        env.timer.trigger()
        env.timer.trigger()
        env.timer.trigger()

        XCTAssertEqual(env.sut.timeSpend, 4)
    }

    func test_setTimer_shouldBecameTimeSpendZEro_whenSetTimeIsCallingAgain() {
        let env = makeEnviroment()
        env.sut.setTimer()
        env.timer.trigger()
        env.timer.trigger()

        env.sut.setTimer()
        env.timer.trigger()

        XCTAssertEqual(env.sut.timeSpend, 1)
    }

    func test_setTimer_shouldNotDelegateWithIncrement_whenTimerNotFire() {
        let env = makeEnviroment()
        env.cycle.triggerStub = nil

        env.sut.setTimer()

        XCTAssertEqual(env.delegate.changeTimeReceived, [0])
    }

    func test_setTimer_shouldNotifyTimeChangeWithIncrement_whenTimerFire() {
        let env = makeEnviroment()
        env.cycle.triggerStub = nil

        env.sut.setTimer()
        env.timer.trigger()

        XCTAssertEqual(env.delegate.changeTimeReceived, [0, 1])
    }

    func test_setTimer_shouldNotifyTimeChangeAllIncrements_whenTimerFireMultipleTimes() {
        let env = makeEnviroment()
        env.cycle.triggerStub = nil

        env.sut.setTimer()
        env.timer.trigger()
        env.timer.trigger()
        env.timer.trigger()

        XCTAssertEqual(env.delegate.changeTimeReceived, [0, 1, 2, 3])
    }

    func test_setTimer_shouldChangeTimeInTheEndWithZero_whenCycleReturnsData() {
        let env = makeEnviroment()
        env.sut.setTimer()
        env.cycle.triggerStub = makePomodoroData()

        env.timer.trigger()

        XCTAssertEqual(env.delegate.changeTimeReceived.last, 0)
        XCTAssertEqual(env.sut.timeSpend, 0)
    }

    func test_setTimer_shouldRemoveTimer_whenCycleReturnsData() {
        let env = makeEnviroment()
        env.cycle.triggerStub = makePomodoroData()

        env.sut.setTimer()
        env.timer.trigger()

        XCTAssertEqual(env.timer.removeTimerCallCount, 2)
    }

    func test_setTimer_shouldDelegateChangePhase_whenCycleReturnsData() {
        let data = makePomodoroData()
        let env = makeEnviroment()
        env.cycle.triggerStub = data

        env.sut.setTimer()
        env.timer.trigger()

        XCTAssertEqual(env.delegate.changePhaseRecieved.first?.phase, data.phase)
        XCTAssertEqual(env.delegate.changePhaseRecieved.first?.cycles, data.cycles)
        XCTAssertEqual(env.delegate.changePhaseRecieved.first?.pomodoros, data.pomodoros)
    }

    private struct Enviroment {
        let sut: Pomodoro
        let cycle: CycleStub
        let timer: PomodoroTimerMock
        let delegate: PomodoroDelegateSpy
    }

    private func makeEnviroment() -> Enviroment {
        let delegate = PomodoroDelegateSpy()
        let timer = PomodoroTimerMock()
        let cycle = CycleStub()
        let sut = Pomodoro(timer: timer, cycle: cycle)
        sut.delegate = delegate

        trackMemmoryLeak(timer)
        trackMemmoryLeak(delegate)
        trackMemmoryLeak(cycle)
        trackMemmoryLeak(sut)

        return Enviroment(sut: sut, cycle: cycle, timer: timer, delegate: delegate)
    }

    private class CycleStub: Cycle {
        private(set) var timeSpendReceived = [Int]()
        var triggerStub: PomodoroData?
        func trigger(timeSpend: Int) -> PomodoroData? {
            timeSpendReceived.append(timeSpend)
            return triggerStub
        }
    }

    private class PomodoroDelegateSpy: PomodoroDelegate {

        private(set) var changeTimeReceived = [Int]()
        private(set) var changePhaseRecieved = [PhaseData]()

        func changeTime(_ time: Int) {
            changeTimeReceived.append(time)
        }

        func changePhase(_ phase: PhaseData) {
            changePhaseRecieved.append(phase)
        }
    }

    private class PomodoroTimerMock: PomodoroTimer {

        private(set) var setTimerRecieved = [() -> Void]()
        private(set) var removeTimerCallCount = 0

        func setTimer(execute: @escaping () -> Void) {
            setTimerRecieved.append(execute)
        }

        func removeTimer() {
            removeTimerCallCount += 1
        }

        func trigger(at index: Int = 0) {
            setTimerRecieved[index]()
        }
    }

    private func makePomodoroData(phase: PomodoroPhase = .focus) -> PomodoroData {
        PomodoroData(
            phase: phase,
            cycles: makeRandomInteger(),
            pomodoros: makeRandomInteger()
        )
    }

    private func makeRandomInteger() -> Int {
        Int.random(in: (0..<100))
    }
}
