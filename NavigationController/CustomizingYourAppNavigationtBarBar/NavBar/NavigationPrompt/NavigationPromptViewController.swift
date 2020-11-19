/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Demonstrates displaying text above the navigation bar.
*/

import UIKit

class NavigationPromptViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
/// - Tag: PromptExample
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.prompt = NSLocalizedString("Navigation prompts appear at the top.", comment: "")
    }

}
