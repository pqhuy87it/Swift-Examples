/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The application's main (initial) view controller.
*/

import UIKit

class MainViewController: UITableViewController, UIActionSheetDelegate {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    /**
     *  Unwind action that is targeted by the demos which present a modal view
     *  controller, to return to the main screen.
     */
    @IBAction func unwindToMainViewController(_ sender: UIStoryboardSegue) {
        tableView.deselectRow(at: tableView!.indexPathForSelectedRow!, animated: false)
    }
    
    // MARK: - Style AlertController
	
    /// User tapped the left 'Style' bar button item.
    /// - Tag: BarStyleExample
    @IBAction func styleAction(_ sender: AnyObject) {
        let title = NSLocalizedString("Choose a UIBarStyle:", comment: "")
        let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
        let defaultButtonTitle = NSLocalizedString("Default", comment: "")
        let blackOpaqueTitle = NSLocalizedString("Black Opaque", comment: "")
        let blackTranslucentTitle = NSLocalizedString("Black Translucent", comment: "")
		
		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)

		alertController.addAction(UIAlertAction(title: NSLocalizedString(cancelButtonTitle, comment: ""),
		                                        style: .cancel) { _ in })
		alertController.addAction(UIAlertAction(title: NSLocalizedString(defaultButtonTitle, comment: ""),
		                                        style: .default) { _ in
			self.navigationController!.navigationBar.barStyle = .default
			// Bars are translucent by default.
			self.navigationController!.navigationBar.isTranslucent = true
			// Reset the bar's tint color to the system default.
			self.navigationController!.navigationBar.tintColor = nil
            self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
		})
		alertController.addAction(UIAlertAction(title: NSLocalizedString(blackOpaqueTitle, comment: ""),
		                                        style: .default) { _ in
			// Change to black-opaque.
			self.navigationController!.navigationBar.barStyle = .black
            self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
			self.navigationController!.navigationBar.isTranslucent = false
			self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
		})
		alertController.addAction(UIAlertAction(title: NSLocalizedString(blackTranslucentTitle, comment: ""),
		                                        style: .default) { _ in
			// Change to black-translucent.

            self.navigationController!.navigationBar.barStyle = .black
            self.navigationController!.navigationBar.isTranslucent = true
            self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
		})
		self.present(alertController, animated: true, completion: nil)
    }

}
