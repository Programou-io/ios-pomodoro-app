import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        setupWindow(window: UIWindow(windowScene: windowScene))
    }

    func setupWindow(window: UIWindow) {
        self.window = window
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
