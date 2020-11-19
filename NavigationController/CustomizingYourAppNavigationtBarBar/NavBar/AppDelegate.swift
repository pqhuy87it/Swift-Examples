/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application delegate class.
*/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate {
    
    var window: UIWindow?
    
    /// - Tag: BackImageButtonExample
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		if let navController = window!.rootViewController as? UINavigationController {
			navController.delegate = self
		}
		
        // For Back button customization, setup the custom image for UINavigationBar inside CustomBackButtonNavController.
        let backButtonBackgroundImage = UIImage(systemName: "list.bullet")
        let barAppearance =
            UINavigationBar.appearance(whenContainedInInstancesOf: [CustomBackButtonNavController.self])
        barAppearance.backIndicatorImage = backButtonBackgroundImage
        barAppearance.backIndicatorTransitionMaskImage = backButtonBackgroundImage
        
        // Nudge the back UIBarButtonItem image down a bit.
        let barButtonAppearance =
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [CustomBackButtonNavController.self])
        barButtonAppearance.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -5), for: .default)
        
        return true
    }
    
    // MARK: - UINavigationControllerDelegate
    
    /**
  		Force the navigation controller to defer to the topViewController for its supportedInterfaceOrientations.
        This allows some of the demos to rotate into landscape while keeping the rest in portrait.
     */
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return navigationController.topViewController!.supportedInterfaceOrientations
    }
    
}
