import UIKit

protocol AppIconHandlerDelegate: AnyObject {
    var interfaceStyle: UIUserInterfaceStyle { get }

    func getAlternateIcon() -> String
    func setAlternateIcon(iconName: String)
}

final class AppIconHandlerSceneDelegate: NSObject, UIWindowSceneDelegate {
    weak var delegate: AppIconHandlerDelegate?

    func sceneDidBecomeActive(_ scene: UIScene) { didBecameActive() }

    func didBecameActive() {
        guard let delegate else { return }
        guard
            let icon = chooseIcon(
                deviceMode: delegate.interfaceStyle,
                currentIcon: delegate.getAlternateIcon()
            )
        else { return }

        delegate.setAlternateIcon(iconName: icon.rawValue)
    }

    func chooseIcon(deviceMode: UIUserInterfaceStyle, currentIcon: String) -> AppIcon? {
        let isDarkMode = deviceMode == .dark
        let icon = AppIcon(rawValue: currentIcon)

        let isDarkIcon = icon == .darkIcon
        if isDarkMode && isDarkIcon { return nil }

        let isLightIcon = icon == .lightIcon
        if !isDarkMode && isLightIcon { return nil }

        return isDarkMode ? .darkIcon : .lightIcon
    }
}
