import XCTest

@testable import Pom

final class PomorodoCycleTests: XCTestCase {
    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForFocus() {
        let sut = makeSUT()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForFocus() {
        let sut = makeSUT()
        XCTAssertNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs900ForFocus() {
        let sut = makeSUT()
        XCTAssertNil(sut.spendLongBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs1499ForFocus() {
        let sut = makeSUT()
        XCTAssertNil(sut.trigger(timeSpend: 1499))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1500ForFocus() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.spendFocusTime())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1501ForFocus() {
        let sut = makeSUT()
        XCTAssertNotNil(sut.trigger(timeSpend: 1501))
    }

    func test_trigger_shouldReturnShortBreakPhase_whenFocusDurationIsFilled() {
        let sut = makeSUT()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.phase, .shortBreak)
    }

    func test_trigger_shouldReturnNoCycles_whenFocusDurationIsFilled() {
        let sut = makeSUT()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.cycles, 0)
    }

    func test_trigger_shouldReturnNoPomodoros_whenFocusDurationIsFilled() {
        let sut = makeSUT()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForShortBreak() {
        let sut = makeSUT()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs250ForShortBreak() {
        let sut = makeSUT()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 250))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs299ForShortBreak() {
        let sut = makeSUT()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 299))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs300ForShortBreak() {
        let sut = makeSUT()
        sut.spendFocusTime()
        XCTAssertNotNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs301ForShortBreak() {
        let sut = makeSUT()
        sut.spendFocusTime()
        XCTAssertNotNil(sut.trigger(timeSpend: 301))
    }

    func test_trigger_shouldReturnFocusPhase_whenShortBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func test_trigger_shouldReturnOneCycle_whenShortBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.cycles, 1)
    }

    func test_trigger_shouldReturnNoPomodoros_whenShortBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs900ForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNil(sut.spendLongBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs1499ForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNil(sut.trigger(timeSpend: 1499))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1500ForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNotNil(sut.spendFocusTime())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1501ForFocusOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        XCTAssertNotNil(sut.trigger(timeSpend: 1501))
    }

    func test_trigger_shouldReturnShortBreakPhase_whenFocusDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.phase, .shortBreak)
    }

    func test_trigger_shouldReturnNoCycles_whenFocusDurationIsFilledOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.cycles, 1)
    }

    func test_trigger_shouldReturnNoPomodoros_whenFocusDurationIsFilledOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        let pomodoro = sut.spendFocusTime()
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForShortBreakOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs250ForShortBreakOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 250))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs299ForShortBreakOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        XCTAssertNil(sut.trigger(timeSpend: 299))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs300ForShortBreakOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        XCTAssertNotNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs301ForShortBreakOnSecondTime() {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        XCTAssertNotNil(sut.trigger(timeSpend: 301))
    }

    func
        test_trigger_shouldReturnFocusPhase_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func
        test_trigger_shouldReturnOneCycle_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.cycles, 2)
    }

    func
        test_trigger_shouldReturnNoPomodoros_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.spendFocusTime()
        sut.spendShortBreak()
        sut.spendFocusTime()
        let pomodoro = sut.spendShortBreak()
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForLongBreak() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForLongBreak() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        XCTAssertNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs899ForLongBreak() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        XCTAssertNil(sut.trigger(timeSpend: 899))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs900ForLongBreak() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        XCTAssertNotNil(sut.spendLongBreak())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs901ForLongBreak() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        XCTAssertNotNil(sut.trigger(timeSpend: 901))
    }

    func test_trigger_shouldReturnFocusPhase_whenLongBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func test_trigger_shouldReturnNoCycles_whenLongBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.cycles, 0)
    }

    func test_trigger_shouldReturnOnePomodoro_whenLongBreakDurationDurationIsFilled() {
        let sut = makeSUT()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.pomodoros, 1)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForLongBreakOnSecondTime() {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForLongBreakOnSecondTime() {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        XCTAssertNil(sut.spendShortBreak())
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs899ForLongBreakOnSecondTime() {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        XCTAssertNil(sut.trigger(timeSpend: 899))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs900ForLongBreakOnSecondTime() {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        XCTAssertNotNil(sut.spendLongBreak())
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs901ForLongBreakOnSecondTime() {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        XCTAssertNotNil(sut.trigger(timeSpend: 901))
    }

    func
        test_trigger_shouldReturnFocusPhase_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func
        test_trigger_shouldReturnNoCycles_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.cycles, 0)
    }

    func
        test_trigger_shouldReturnOnePomodoro_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = makeSUT()
        sut.completePomodoro()
        sut.spendToLongBreak()
        let pomodoro = sut.spendLongBreak()
        XCTAssertEqual(pomodoro?.pomodoros, 2)
    }

    private func makeSUT() -> PomorodoCycle {
        PomorodoCycle()
    }
}

extension PomorodoCycle {
    @discardableResult
    func spendFocusTime() -> PomodoroData? {
        trigger(timeSpend: 1500)
    }

    @discardableResult
    func spendShortBreak() -> PomodoroData? {
        trigger(timeSpend: 300)
    }

    @discardableResult
    func spendLongBreak() -> PomodoroData? {
        trigger(timeSpend: 900)
    }

    func spendToLongBreak() {
        spendFocusTime()
        spendShortBreak()
        spendFocusTime()
        spendShortBreak()
        spendFocusTime()
        spendShortBreak()
        spendFocusTime()
    }

    func completePomodoro() {
        spendToLongBreak()
        spendLongBreak()
    }
}
