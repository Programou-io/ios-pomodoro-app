import XCTest

@testable import Pom

final class PomodoroViewModelTests: XCTestCase {

    func test_shouldSetPomodoroDelegate() {
        let env = makeEnviroment()

        XCTAssertNotNil(env.pomodoro.delegate)
    }

    func test_shouldCallDelegateMethods_whenSetupInitialStateWasCalled() {
        let env = makeEnviroment()

        env.sut.setupInitialState()

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [
                PomodoroTimeViewData(time: "00:25:00", progress: 0.0)
            ]
        )
        XCTAssertEqual(
            env.delegate.changeButtonRecieved,
            [
                .init(title: "iniciar foco")
            ]
        )
        XCTAssertEqual(
            env.delegate.changeCyclesRecieved,
            [
                .init(period: 0.0)
            ]
        )
        XCTAssertEqual(
            env.delegate.changePhaseRecieved,
            [
                .init(phase: .focus)
            ]
        )
        XCTAssertEqual(
            env.delegate.changePomodorosRecieved,
            [
                .init(pomodoros: "0")
            ]
        )
    }

    func test_startCycle_shouldDelegateChangeTimeWithZeroFormatted() {
        let env = makeEnviroment()
        env.sut.startCycle()
        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:00:00", progress: 0.0)]
        )
    }

    func test_startCycle_shouldDelegateChangeButtonStop() {
        let env = makeEnviroment()
        env.sut.startCycle()
        XCTAssertEqual(
            env.delegate.changeButtonRecieved,
            [PomodoroButtonViewData(title: "pausar")]
        )
    }

    func test_startCycle_shouldSetPomodoroTimerOnce() {
        let env = makeEnviroment()
        env.sut.startCycle()
        XCTAssertEqual(env.pomodoro.setTimerCallCount, 1)
    }

    func test_implementedChangeTime_shouldUpdateTimeWithZero_whenPomodoroDeleiversZero() {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(0, phase: .focus)

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:00:00", progress: 0)]
        )
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWithOneMinute_whenPomodoroDeleivers60Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(60, phase: .focus)

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:01:00", progress: 0.04)]
        )
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWithOneHour_whenPomodoroDeleivers3600Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(3600, phase: .shortBreak)

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "01:00:00", progress: 12.0)]
        )
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWithOneHourAndOPneMinute_whenPomodoroDeleivers3601Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(3601, phase: .longBreak)

        XCTAssertEqual(env.delegate.changeTimeRecieved[0].time, "01:00:01")
        XCTAssertEqual(env.delegate.changeTimeRecieved[0].progress, 4.00, accuracy: 0.1)
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWith25Minutes_whenPomodoroDeleivers1500Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(1500, phase: .focus)

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:25:00", progress: 1.0)]
        )
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWith15Minutes_whenPomodoroDeleivers900Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(900, phase: .focus)

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:15:00", progress: 0.6)]
        )
    }

    func
        test_implementedChangeTime_shouldUpdateTimeWith5Minutes_whenPomodoroDeleivers300Seconds()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changeTime(300, phase: .longBreak)

        XCTAssertEqual(env.delegate.changeTimeRecieved[0].time, "00:05:00")
        XCTAssertEqual(env.delegate.changeTimeRecieved[0].progress, 0.333, accuracy: 0.1)
    }

    func test_implementedChangePhase_shouldDelegatesChangePhaseWithCorrectPhase() {
        let env = makeEnviroment()

        let data = makePhaseData()
        env.pomodoro.delegate?.changePhase(data)

        XCTAssertEqual(
            env.delegate.changePhaseRecieved,
            [PomodoroPhaseViewData(phase: data.phase)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeCycleWith25Percent_whenPomodoroDeleiversOneCycle()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(cycles: 1))

        XCTAssertEqual(
            env.delegate.changeCyclesRecieved,
            [PomodoroCyclesViewData(period: 0.25)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeCycleWith100Percent_whenPomodoroDeleivers4Cycles()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(cycles: 4))

        XCTAssertEqual(
            env.delegate.changeCyclesRecieved,
            [PomodoroCyclesViewData(period: 1.0)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeCycleWith0Percent_whenPomodoroDeleivers0Cycles()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(cycles: 0))

        XCTAssertEqual(
            env.delegate.changeCyclesRecieved,
            [PomodoroCyclesViewData(period: 0)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeCycleWith75Percent_whenPomodoroDeleivers3Cycles()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(cycles: 3))

        XCTAssertEqual(
            env.delegate.changeCyclesRecieved,
            [PomodoroCyclesViewData(period: 0.75)]
        )
    }

    func test_implementedChangePhase_shouldDelegatesChangePomodorosEqualReceived() {
        let data = makePhaseData()
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(data)

        XCTAssertEqual(
            env.delegate.changePomodorosRecieved,
            [PomodoroDoneViewData(pomodoros: "\(data.pomodoros)")]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeButtonToStartFocus_whenPhaseIsFocus()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .focus))

        XCTAssertEqual(
            env.delegate.changeButtonRecieved,
            [PomodoroButtonViewData(title: "iniciar foco")]
        )
    }

    func test_implementedChangePhase_shouldDelegatesChangeTimeToDefault_whenPhaseIsFocus()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .focus))

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:25:00", progress: 0.0)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeButtonToStartShortBreak_whenPhaseIsShortBreak()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .shortBreak))

        XCTAssertEqual(
            env.delegate.changeButtonRecieved,
            [PomodoroButtonViewData(title: "iniciar pausa curta")]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeTimeToDefault_whenPhaseIsShortBreak()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .shortBreak))

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:05:00", progress: 0.0)]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeButtonToStartLongBreak_whenPhaseIsLongBreak()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .longBreak))

        XCTAssertEqual(
            env.delegate.changeButtonRecieved,
            [PomodoroButtonViewData(title: "iniciar pausa longa")]
        )
    }

    func
        test_implementedChangePhase_shouldDelegatesChangeTimeToDefault_whenPhaseIsLongBreak()
    {
        let env = makeEnviroment()

        env.pomodoro.delegate?.changePhase(makePhaseData(phase: .longBreak))

        XCTAssertEqual(
            env.delegate.changeTimeRecieved,
            [PomodoroTimeViewData(time: "00:15:00", progress: 0.0)]
        )
    }

    private struct Enviroment {
        let sut: PomodoroViewModel
        let pomodoro: PomodoroSpy
        let delegate: PomodoroViewModelDelegateSpy
    }

    private func makeEnviroment() -> Enviroment {
        let delegate = PomodoroViewModelDelegateSpy()
        let pomodoroUseCase = PomodoroSpy()
        let sut = PomodoroViewModel(pomodoro: pomodoroUseCase)
        sut.delegate = delegate

        trackMemmoryLeak(delegate)
        trackMemmoryLeak(pomodoroUseCase)
        trackMemmoryLeak(sut)

        return Enviroment(sut: sut, pomodoro: pomodoroUseCase, delegate: delegate)
    }

    private final class PomodoroSpy: Pomodorable {
        var delegate: PomodoroDelegate?

        private(set) var setTimerCallCount = 0
        func setTimer() {
            setTimerCallCount += 1
        }
    }

    private final class PomodoroViewModelDelegateSpy: PomodoroViewModelDelegate {

        private(set) var changeButtonRecieved = [PomodoroButtonViewData]()
        private(set) var changeTimeRecieved = [PomodoroTimeViewData]()
        private(set) var changePhaseRecieved = [PomodoroPhaseViewData]()
        private(set) var changeCyclesRecieved = [PomodoroCyclesViewData]()
        private(set) var changePomodorosRecieved = [PomodoroDoneViewData]()

        func changeTime(viewData: PomodoroTimeViewData) {
            changeTimeRecieved.append(viewData)
        }

        func changeButton(viewData: PomodoroButtonViewData) {
            changeButtonRecieved.append(viewData)
        }

        func changePhase(viewData: PomodoroPhaseViewData) {
            changePhaseRecieved.append(viewData)
        }

        func changeCycles(viewData: PomodoroCyclesViewData) {
            changeCyclesRecieved.append(viewData)
        }

        func changePomodoros(viewData: PomodoroDoneViewData) {
            changePomodorosRecieved.append(viewData)
        }
    }

    private func makePhaseData(
        phase: PomodoroPhase = .focus,
        cycles: Int = makeRandomInteger(),
        pomodoros: Int = makeRandomInteger()
    ) -> PhaseData {
        PhaseData(phase: phase, cycles: cycles, pomodoros: pomodoros)
    }
}

extension PomodoroTimeViewData: Equatable {
    public static func == (lhs: PomodoroTimeViewData, rhs: PomodoroTimeViewData) -> Bool {
        lhs.time == rhs.time && lhs.progress == rhs.progress
    }
}
extension PomodoroButtonViewData: Equatable {
    public static func == (lhs: PomodoroButtonViewData, rhs: PomodoroButtonViewData)
        -> Bool
    {
        lhs.title == rhs.title
    }
}
extension PomodoroPhaseViewData: Equatable {
    public static func == (lhs: PomodoroPhaseViewData, rhs: PomodoroPhaseViewData) -> Bool
    {
        lhs.phase == rhs.phase
    }
}
extension PomodoroCyclesViewData: Equatable {
    public static func == (lhs: PomodoroCyclesViewData, rhs: PomodoroCyclesViewData)
        -> Bool
    {
        lhs.period == rhs.period
    }
}
extension PomodoroDoneViewData: Equatable {
    public static func == (lhs: PomodoroDoneViewData, rhs: PomodoroDoneViewData) -> Bool {
        lhs.pomodoros == rhs.pomodoros
    }
}
