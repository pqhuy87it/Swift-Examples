/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Demonstrates applying a custom background to a navigation bar.
*/

import UIKit

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [CGColor]) -> UIImage {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = colors
        
        UIGraphicsBeginImageContext(gradient.bounds.size)
        gradient.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

// MARK: -

class CustomAppearanceViewController: UITableViewController {

    @IBOutlet var backgroundSwitcher: UISegmentedControl!

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
	/// Our data source is an array of city names, populated from Cities.json.
	let dataSource = CitiesDataSource()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.dataSource = dataSource
		
        // Place the background switcher in the toolbar.
        let backgroundSwitcherItem = UIBarButtonItem(customView: backgroundSwitcher)
        toolbarItems = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            backgroundSwitcherItem,
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        ]
        
        applyImageBackgroundToTheNavigationBar()
    }
	
    /**
    	Configures the navigation bar to use an image as its background.
     */
    /// - Tag: BackgroundImageExample
    func applyImageBackgroundToTheNavigationBar() {
   
        guard let bounds = navigationController?.navigationBar.bounds else { return }
        
        var backImageForDefaultBarMetrics =
            UIImage.gradientImage(bounds: bounds,
                                  colors: [UIColor.systemBlue.cgColor, UIColor.systemFill.cgColor])
        var backImageForLandscapePhoneBarMetrics =
            UIImage.gradientImage(bounds: bounds,
                                  colors: [UIColor.systemTeal.cgColor, UIColor.systemFill.cgColor])
        
        /*  Both of the above images are smaller than the navigation bar's size.
            To enable the images to resize gracefully while keeping their
            content pinned to the bottom right corner of the bar, the images are
            converted into resizable images width edge insets extending from the
            bottom up to the second row of pixels from the top, and from the
            right over to the second column of pixels from the left. This results
            in the topmost and leftmost pixels being stretched when the images
            are resized. Not coincidentally, the pixels in these rows/columns are empty.
         */
        backImageForDefaultBarMetrics =
            backImageForDefaultBarMetrics.resizableImage(
                withCapInsets: UIEdgeInsets(top: 0,
                                            left: 0,
                                            bottom: backImageForDefaultBarMetrics.size.height - 1,
                                            right: backImageForDefaultBarMetrics.size.width - 1))
        backImageForLandscapePhoneBarMetrics =
            backImageForLandscapePhoneBarMetrics.resizableImage(
                withCapInsets: UIEdgeInsets(top: 0,
                                            left: 0,
                                            bottom: backImageForLandscapePhoneBarMetrics.size.height - 1,
                                            right: backImageForLandscapePhoneBarMetrics.size.width - 1))
        
        /*  You should use the appearance proxy to customize the appearance of
            UIKit elements. However changes made to an element's appearance
            proxy do not effect any existing instances of that element currently
            in the view hierarchy. Normally this is not an issue because you
            will likely be performing your appearance customizations in
            -application:didFinishLaunchingWithOptions:. However, this example
            allows you to toggle between appearances at runtime which necessitates
            applying appearance customizations directly to the navigation bar.
        */
        
        // Uncomment this line to use the appearance proxy to customize the appearance of UIKit elements.
        // let navigationBarAppearance =
        //      UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])

        /*  The bar metrics associated with a background image determine when it is used.
            The background image associated with the Default bar metrics is
            used when a more suitable background image can not be found.
         
            The background image associated with the LandscapePhone bar metrics
            is used by the shorter variant of the navigation bar that is used on
            iPhone when in landscape.
         */

        let navigationBarAppearance = self.navigationController!.navigationBar
        navigationBarAppearance.setBackgroundImage(backImageForDefaultBarMetrics, for: .default)
        navigationBarAppearance.setBackgroundImage(backImageForLandscapePhoneBarMetrics, for: .compact)
    }
    
    /**
		Configures the navigation bar to use a transparent background
        (see-through but without any blur).
     */
    func applyTransparentBackgroundToTheNavigationBar(_ opacity: CGFloat) {
        var transparentBackground: UIImage
        
        /*	The background of a navigation bar switches from being translucent
        	to transparent when a background image is applied. The intensity of
   			the background image's alpha channel is inversely related to the
      		transparency of the bar. That is, a smaller alpha channel intensity
       		results in a more transparent bar and vis-versa.

  			Below, a background image is dynamically generated with the desired opacity.
		*/
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1),
											   false,
											   navigationController!.navigationBar.layer.contentsScale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(red: 1, green: 1, blue: 1, alpha: opacity)
        UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
        transparentBackground = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        /*	You should use the appearance proxy to customize the appearance of
      		UIKit elements. However changes made to an element's appearance
			proxy do not effect any existing instances of that element currently
   			in the view hierarchy. Normally this is not an issue because you
   			will likely be performing your appearance customizations in
			-application:didFinishLaunchingWithOptions:. However, this example
 			allows you to toggle between appearances at runtime which necessitates
   			applying appearance customizations directly to the navigation bar.
		*/

        let navigationBarAppearance = self.navigationController!.navigationBar
        navigationBarAppearance.setBackgroundImage(transparentBackground, for: .default)
    }
    
    /**
     *  Configures the navigation bar to use a custom color as its background.
     *  The navigation bar remains translucent.
     */
    func applyBarTintColorToTheNavigationBar() {
        /*  Be aware when selecting a barTintColor for a translucent bar that
            the tint color will be blended with the content passing under
            the translucent bar.  See QA1808 for more information.
            <https://developer.apple.com/library/ios/qa/qa1808/_index.html>
		*/
        let barTintColor = #colorLiteral(red: 0.7388114333, green: 0.9007369876, blue: 0.7299064994, alpha: 1)
		let darkendBarTintColor = #colorLiteral(red: 0.5541667552, green: 0.7134873905, blue: 0.5476607554, alpha: 1)
	
        /*	You should use the appearance proxy to customize the appearance of
 			UIKit elements. However changes made to an element's appearance
  			proxy do not effect any existing instances of that element currently
    		in the view hierarchy. Normally this is not an issue because you
       		will likely be performing your appearance customizations in
     		-application:didFinishLaunchingWithOptions:. However, this example
   			allows you to toggle between appearances at runtime which necessitates
    		applying appearance customizations directly to the navigation bar.
		*/
        // let navigationBarAppearance =
        //      UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
        let navigationBarAppearance = self.navigationController!.navigationBar
        
        navigationBarAppearance.barTintColor = darkendBarTintColor

        // For comparison, apply the same barTintColor to the toolbar, which has been configured to be opaque.
        navigationController!.toolbar.barTintColor = barTintColor
        navigationController!.toolbar.isTranslucent = false
    }
	
	// MARK: - UIContentContainer
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		/*	This works around a bug in iOS 8.0 - 8.2 in which the navigation bar
			will not display the correct background image after rotating the device.
			This bug affects bars in navigation controllers that are presented
			modally. A bar in the window's rootViewController would not be affected.
		*/
		coordinator.animate(alongsideTransition: { _ in
			/* 	The workaround is to toggle some appearance related setting on the
				navigation bar when we detect that the view controller has changed
				interface orientations. In our example, we call the
				-configureNewNavBarBackground: which reapplies our appearance
				based on the current selection. In a real app, changing just the
				barTintColor or barStyle would have the same effect.
			*/
			self.configureNewNavBarBackground(self.backgroundSwitcher)
		}, completion: nil)
	}
	
    // MARK: - Background Switcher
    
    @IBAction func configureNewNavBarBackground(_ sender: UISegmentedControl) {
        // Reset everything.
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController!.navigationBar.setBackgroundImage(nil, for: .compact)
        self.navigationController!.navigationBar.barTintColor = nil
        self.navigationController!.toolbar.barTintColor = nil
        self.navigationController!.toolbar.isTranslucent = true
        
        switch sender.selectedSegmentIndex {
        case 0: // Transparent Background
            applyImageBackgroundToTheNavigationBar()
        case 1: // Transparent
            applyTransparentBackgroundToTheNavigationBar(0.87)
        case 2: // Colored
            applyBarTintColorToTheNavigationBar()
        default:
            break
        }
    }

}
