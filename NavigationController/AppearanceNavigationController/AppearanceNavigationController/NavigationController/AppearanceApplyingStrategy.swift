import Foundation
import UIKit
import QuartzCore

public class AppearanceApplyingStrategy {
    
    public func apply(_ appearance: Appearance?, toNavigationController navigationController: UINavigationController, animated: Bool) {
        if let appearance = appearance {
            let navigationBar = navigationController.navigationBar
            let toolbar = navigationController.toolbar
            
            if !navigationController.isNavigationBarHidden {
                let background = ImageRenderer.renderImageOfColor(color: appearance.navigationBar.backgroundColor)
                navigationBar.setBackgroundImage(background, for: .default)
                navigationBar.tintColor = appearance.navigationBar.tintColor
                navigationBar.barTintColor = appearance.navigationBar.barTintColor
                navigationBar.titleTextAttributes = [
                    NSAttributedString.Key.foregroundColor: appearance.navigationBar.tintColor
                ]
            }

            guard let renderImage = ImageRenderer.renderImageOfColor(color: appearance.toolbar.backgroundColor) else { return }
            if !navigationController.isToolbarHidden {
                toolbar?.setBackgroundImage(
                    renderImage,
                    forToolbarPosition: .any,
                    barMetrics: .default
                )
                toolbar?.tintColor = appearance.toolbar.tintColor
                toolbar?.barTintColor = appearance.toolbar.barTintColor
            }
        }
    }
}
