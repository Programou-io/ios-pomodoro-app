import XCTest

@testable import Pom

struct Pomodoro {
    let phase: PomodoroPhase
    let cycles: Int
    let pomodoros: Int
}

class PomorodoCycle {
    private var phase: PomodoroPhase = .focus
    private var cycles = 0
    private var pomodoros = 0

    func trigger(timeSpend: Double) -> Pomodoro? {
        guard timeSpend >= phase.duration else {
            return nil
        }

        switch phase {
        case .focus:
            if cycles < 3 {
                phase = .shortBreak
            } else {
                phase = .longBreak
            }
        case .shortBreak:
            phase = .focus
            cycles += 1
        case .longBreak:
            phase = .focus
            cycles = 0
            pomodoros += 1
        }

        return Pomodoro(phase: phase, cycles: cycles, pomodoros: pomodoros)
    }
}

final class PomorodoCycleTests: XCTestCase {
    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs900ForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNil(sut.trigger(timeSpend: 900))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs1499ForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNil(sut.trigger(timeSpend: 1499))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1500ForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNotNil(sut.trigger(timeSpend: 1500))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1501ForFocus() {
        let sut = PomorodoCycle()
        XCTAssertNotNil(sut.trigger(timeSpend: 1501))
    }

    func test_trigger_shouldReturnShortBreakPhase_whenFocusDurationIsFilled() {
        let sut = PomorodoCycle()
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.phase, .shortBreak)
    }

    func test_trigger_shouldReturnNoCycles_whenFocusDurationIsFilled() {
        let sut = PomorodoCycle()
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.cycles, 0)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNoPomodoros_whenFocusDurationIsFilled() {
        let sut = PomorodoCycle()
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForShortBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs250ForShortBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 250))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs299ForShortBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 299))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs300ForShortBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNotNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs301ForShortBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNotNil(sut.trigger(timeSpend: 301))
    }

    func test_trigger_shouldReturnFocusPhase_whenShortBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func test_trigger_shouldReturnOneCycle_whenShortBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.cycles, 1)
    }

    func test_trigger_shouldReturnNoPomodoros_whenShortBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs900ForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNil(sut.trigger(timeSpend: 900))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs1499ForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNil(sut.trigger(timeSpend: 1499))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1500ForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNotNil(sut.trigger(timeSpend: 1500))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs1501ForFocusOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        XCTAssertNotNil(sut.trigger(timeSpend: 1501))
    }

    func test_trigger_shouldReturnShortBreakPhase_whenFocusDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.phase, .shortBreak)
    }

    func test_trigger_shouldReturnNoCycles_whenFocusDurationIsFilledOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.cycles, 1)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNoPomodoros_whenFocusDurationIsFilledOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        let pomodoro = sut.trigger(timeSpend: 1500)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForShortBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs250ForShortBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 250))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs299ForShortBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNil(sut.trigger(timeSpend: 299))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs300ForShortBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNotNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs301ForShortBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        XCTAssertNotNil(sut.trigger(timeSpend: 301))
    }

    func
        test_trigger_shouldReturnFocusPhase_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func
        test_trigger_shouldReturnOneCycle_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.cycles, 2)
    }

    func
        test_trigger_shouldReturnNoPomodoros_whenShortBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)
        _ = sut.trigger(timeSpend: 300)
        _ = sut.trigger(timeSpend: 1500)
        let pomodoro = sut.trigger(timeSpend: 300)
        XCTAssertEqual(pomodoro?.pomodoros, 0)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForLongBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForLongBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x = 1
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x = 2
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x = 3
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs899ForLongBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x = 1
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x = 2
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x = 3
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 899))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs900ForLongBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNotNil(sut.trigger(timeSpend: 900))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs901ForLongBreak() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNotNil(sut.trigger(timeSpend: 901))
    }

    func test_trigger_shouldReturnFocusPhase_whenLongBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func test_trigger_shouldReturnNoCycles_whenLongBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.cycles, 0)
    }

    func test_trigger_shouldReturnOnePomodoro_whenLongBreakDurationDurationIsFilled() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.pomodoros, 1)
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIsZeroForLongBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 0))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs300ForLongBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 300))
    }

    func test_trigger_shouldReturnNil_whenTimeSpendIs899ForLongBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNil(sut.trigger(timeSpend: 899))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs900ForLongBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNotNil(sut.trigger(timeSpend: 900))
    }

    func test_trigger_shouldReturnNotNil_whenTimeSpendIs901ForLongBreakOnSecondTime() {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        XCTAssertNotNil(sut.trigger(timeSpend: 901))
    }

    func
        test_trigger_shouldReturnFocusPhase_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.phase, .focus)
    }

    func
        test_trigger_shouldReturnNoCycles_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.cycles, 0)
    }

    func
        test_trigger_shouldReturnOnePomodoro_whenLongBreakDurationDurationIsFilledOnSecondTime()
    {
        let sut = PomorodoCycle()
        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        _ = sut.trigger(timeSpend: 900)  //pausa longa

        _ = sut.trigger(timeSpend: 1500)  //foco 1x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 1x
        _ = sut.trigger(timeSpend: 1500)  //foco 2x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 2x
        _ = sut.trigger(timeSpend: 1500)  //foco 3x
        _ = sut.trigger(timeSpend: 300)  //pausa curta 3x
        _ = sut.trigger(timeSpend: 1500)  //foco 4x
        let pomodoro = sut.trigger(timeSpend: 900)
        XCTAssertEqual(pomodoro?.pomodoros, 2)
    }
}
