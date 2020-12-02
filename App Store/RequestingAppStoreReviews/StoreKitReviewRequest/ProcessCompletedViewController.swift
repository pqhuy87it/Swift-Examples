/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The process completed view controller scene.
*/

import UIKit
import StoreKit

class ProcessCompletedViewController: UIViewController {

    // MARK: View lifecycle

    /// - Tag: RequestReview
    override func viewDidLoad() {
        super.viewDidLoad()

        // If the count has not yet been stored, this will return 0
        var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
        count += 1
        UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
        
        print("Process completed \(count) time(s)")
        
        // Get the current bundle version for the app
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { fatalError("Expected to find a bundle version in the info dictionary") }
        
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
        
        // Has the process been completed several times and the user has not already been prompted for this version?
        if count >= 4 && currentVersion != lastVersionPromptedForReview {
            let twoSecondsFromNow = DispatchTime.now() + 2.0
            DispatchQueue.main.asyncAfter(deadline: twoSecondsFromNow) { [navigationController] in
                if navigationController?.topViewController is ProcessCompletedViewController {
                    SKStoreReviewController.requestReview()
                    UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
                }
            }
        }
    }

    // MARK: Action methods

    @IBAction func done() {
        navigationController?.popToRootViewController(animated: true)
    }
}
