import Foundation

final class WeakProxy<T: AnyObject> {
    weak var instance: T?

    init(_ instance: T) {
        self.instance = instance
    }
}
