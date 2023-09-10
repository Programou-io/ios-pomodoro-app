import XCTest

@testable import Pom

final class SceneDelegateTests: XCTestCase {
    func test_setupWindow_shouldMakeKeyAndVisibleOnce() {
        let window = WindowSpy()
        let sut = SceneDelegate()
        sut.setupWindow(window: window)
        XCTAssertEqual(window.makeKeyAndVisibleCallCount, 1)
    }
    func test_setupWindow_shouldSetRootViewControlelrAsViewController() throws {
        let window = WindowSpy()
        let sut = SceneDelegate()
        sut.setupWindow(window: window)
        let nav = try XCTUnwrap(window.rootViewController as? UINavigationController)
        XCTAssertTrue(nav.viewControllers.first is PomodoroViewController)
    }
    func test_setupWindow_shouldReplaceInstanceWindowToTheProvided() {
        let window = WindowSpy()
        let sut = SceneDelegate()
        sut.setupWindow(window: window)
        XCTAssertIdentical(sut.window, window)
    }
    private final class WindowSpy: UIWindow {
        private(set) var makeKeyAndVisibleCallCount = 0
        override func makeKeyAndVisible() { makeKeyAndVisibleCallCount += 1 }
    }
}
