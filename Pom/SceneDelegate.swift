import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var appIconDelegate: AppIconHandlerSceneDelegate = {
        let iconHandler = AppIconHandlerSceneDelegate()
        iconHandler.delegate = self
        return iconHandler
    }()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        setupWindow(window: UIWindow(windowScene: windowScene))
    }

    func setupWindow(window: UIWindow) {
        self.window = window
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        appIconDelegate.sceneDidBecomeActive(scene)
    }
}

extension SceneDelegate: AppIconHandlerDelegate {
    var interfaceStyle: UIUserInterfaceStyle {
        window?.traitCollection.userInterfaceStyle ?? .light
    }

    func getAlternateIcon() -> String {
        UIApplication.shared.alternateIconName ?? String()
    }

    func setAlternateIcon(iconName: String) {
        DispatchQueue.main.async { UIApplication.shared.setAlternateIconName(iconName) }
    }
}
