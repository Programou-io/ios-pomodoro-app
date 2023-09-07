import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(
    _ scene: UIScene, willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    setupWindow(window: UIWindow(frame: UIScreen.main.bounds))
  }

  func setupWindow(window: UIWindow) {
    self.window = window
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
  }
}
