import XCTest

@testable import Pom

final class AppIconHandlerSceneDelegateTests: XCTestCase {
    func test_chooseIcon_shouldReturnNil_whenDeviceIsLightAndIconAlreadyLight() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(deviceMode: .light, currentIcon: lightIcon())
        XCTAssertNil(iconName)
    }

    func test_chooseIcon_shouldReturnLightIcon_whenDeviceIsLightAndIconIsDark() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(deviceMode: .light, currentIcon: darkIcon())
        XCTAssertEqual(iconName, .lightIcon)
    }

    func test_chooseIcon_shouldReturnDarkIcon_whenDeviceIsDarkAndIconIsLight() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(deviceMode: .dark, currentIcon: lightIcon())
        XCTAssertEqual(iconName, .darkIcon)
    }

    func test_chooseIcon_shouldReturnNil_whenDeviceIsDarkAndIconAlreadyDark() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(deviceMode: .dark, currentIcon: darkIcon())
        XCTAssertNil(iconName)
    }

    func test_chooseIcon_shouldReturnDark_whenDeviceIsDarkAndIconIsUnknowned() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(
            deviceMode: .dark,
            currentIcon: "any invalid icon name"
        )
        XCTAssertEqual(iconName, .darkIcon)
    }

    func test_chooseIcon_shouldReturnLight_whenDeviceIsLightAndIconIsUnknowned() {
        let env = makeEnviroment()
        let iconName = env.sut.chooseIcon(
            deviceMode: .light,
            currentIcon: "any invalid icon name"
        )
        XCTAssertEqual(iconName, .lightIcon)
    }

    func test_didBecameActive_shouldGetInterfaceStyleOnce() {
        let env = makeEnviroment()
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.interfaceStyleCallCount, 1)
    }

    func test_didBecameActive_shouldGetAlternateIconOnce() {
        let env = makeEnviroment()
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.getAlternateIconCallCount, 1)
    }

    func
        test_didBecameActive_shouldSetAlternateToLightIcon_whenDeviceIsLightAndIconIsUnknowned()
    {
        let env = makeEnviroment()
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [lightIcon()])
    }

    func
        test_didBecameActive_shouldSetAlternateToDarkIcon_whenDeviceIsDarkAndIconIsUnknowned()
    {
        let env = makeEnviroment()
        env.delegate.interfaceStyleStub = .dark
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [darkIcon()])
    }

    func
        test_didBecameActive_shouldNotSetAlternateToAnyIcon_whenDeviceAndIconIsTheLightState()
    {
        let env = makeEnviroment()
        env.delegate.getAlternateIconStub = lightIcon()
        env.delegate.interfaceStyleStub = .light
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [])
    }

    func
        test_didBecameActive_shouldNotSetAlternateToAnyIcon_whenDeviceAndIconIsTheDarkState()
    {
        let env = makeEnviroment()
        env.delegate.getAlternateIconStub = darkIcon()
        env.delegate.interfaceStyleStub = .dark
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [])
    }

    func test_didBecameActive_shouldSetIconAsLight_whenInterfaceIsLightModeAndIconIsnt() {
        let env = makeEnviroment()
        env.delegate.getAlternateIconStub = darkIcon()
        env.delegate.interfaceStyleStub = .light
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [lightIcon()])
    }

    func test_didBecameActive_shouldSetIconAsDark_whenInterfaceIsDarkModeAndIconIsnt() {
        let env = makeEnviroment()
        env.delegate.getAlternateIconStub = lightIcon()
        env.delegate.interfaceStyleStub = .dark
        env.sut.didBecameActive()
        XCTAssertEqual(env.delegate.setAlternateIconReceived, [darkIcon()])
    }

    private struct Enviroment {
        let delegate: AppIconHandlerDelegateSpy
        let sut: AppIconHandlerSceneDelegate
    }

    private func makeEnviroment() -> Enviroment {
        let delegate = AppIconHandlerDelegateSpy()
        let sut = AppIconHandlerSceneDelegate()
        sut.delegate = delegate

        trackMemmoryLeak(sut)
        trackMemmoryLeak(delegate)

        return Enviroment(delegate: delegate, sut: sut)
    }

    private func lightIcon() -> String { AppIcon.lightIcon.rawValue }

    private func darkIcon() -> String { AppIcon.darkIcon.rawValue }

    private func trackMemmoryLeak(
        _ instance: AnyObject,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "\(String(describing: instance)) must be nil, potential memmory leak was found",
                file: file,
                line: line
            )
        }
    }

    private final class AppIconHandlerDelegateSpy: AppIconHandlerDelegate {
        private(set) var interfaceStyleCallCount = 0
        var interfaceStyleStub: UIUserInterfaceStyle = .light
        var interfaceStyle: UIUserInterfaceStyle {
            interfaceStyleCallCount += 1
            return interfaceStyleStub
        }

        private(set) var getAlternateIconCallCount = 0
        var getAlternateIconStub = String()
        func getAlternateIcon() -> String {
            getAlternateIconCallCount += 1
            return getAlternateIconStub
        }

        private(set) var setAlternateIconReceived = [String]()
        func setAlternateIcon(iconName: String) {
            setAlternateIconReceived.append(iconName)
        }
    }
}
