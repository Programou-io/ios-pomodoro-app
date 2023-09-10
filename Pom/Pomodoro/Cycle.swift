import Foundation

class Cycle {
    private let duration: TimeInterval
    private var onFinish: Bind
    private var onCancel: Bind
    private var timeSpend = TimeInterval(0)
    private var timer: Timer?
    init(duration: TimeInterval, onCancel: @escaping Bind, onFinish: @escaping Bind) {
        self.duration = duration
        self.onCancel = onCancel
        self.onFinish = onFinish
    }
    func setTimer(onTimeChange: @escaping BindWith<TimeInterval>) {
        if timer?.isValid == true {
            timer?.invalidate()
            onCancel()
            return
        }
        let oneSecond: TimeInterval = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: oneSecond, repeats: true) {
            timer in self.timeSpend += 1
            onTimeChange(self.timeSpend)
            guard self.timeSpend >= self.duration else { return }
            self.onFinish()
            timer.invalidate()
        }
    }
}
