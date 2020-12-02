# Requesting App Store Reviews

Use best practices for prompting users to leave a review for your app in the App Store. 

## Overview

Presenting the user with a request for an App Store review using [`SKStoreReviewController`](https://developer.apple.com/documentation/storekit/skstorereviewcontroller) is a good way to get feedback on your app. However, you should be aware that the prompt will only be displayed to a user a maximum of three times within a 365-day period. Choosing when and where to display this prompt is critical to your success using this API.   

This sample project consists of a simulated three-step process. The user first taps the "Start Process" button, then taps "Continue Process" twice to finally be presented with a "Process Completed" view controller scene. The request for review is only shown to the user from this scene.

In addition, the following conditions need to be met before the prompt is displayed:

* The review prompt must not have been shown for a version of the app bundle that matches the current bundle version. This ensures that the user is not asked to review the same version of your app multiple times.
* The multistep process mentioned above must be successfully completed at least four times. This number is arbitrary and you should choose something that fits well with how many times the user is likely to complete a process in your app.
* Finally, the user must pause on the "Process Completed" scene for a few seconds. This requirement limits the possibility of the prompt interrupting the user if they are about to move to a different task in your application straight away.

The conditions above exist purely to delay the call to [`requestReview()`](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview) and so days, weeks, or potentially even months could elapse without a user being prompted to review your app. Techniques to delay the call are valuable as they will cause it to be shown to more experienced users that are getting real value from using your app.

## Present the Review Request

Spend some time thinking about the best places within your own app to show a request for review, and what conditions are appropriate to delay it. Here are some best practices:

* Try to make the request at a time that will not interrupt what the user is trying to achieve in your app. For example, at the end of a sequence of events that the user has successfully completed.
* Avoid showing a request for a review immediately when a user launches your app, even if it is not the first time that it launches.

Also remember that the user can disable requests for reviews from *ever* appearing on their device, so you should avoid referring to your app showing this prompt and never request a review using [`requestReview()`](https://developer.apple.com/documentation/storekit/skstorereviewcontroller/2851536-requestreview) as the result of a user action.

``` swift
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
```
[View in Source](x-source-tag://RequestReview)

In this code sample the usage data used to delay the review request is stored in [`UserDefaults`](https://developer.apple.com/documentation/foundation/userdefaults). In your app there may be more appropriate on-device storage options. 

Further information on best practices for requesting reviews can be found in the [ratings and reviews](https://developer.apple.com/ios/human-interface-guidelines/system-capabilities/ratings-and-reviews/) section of the [Human Interface Guidelines](https://developer.apple.com/ios/human-interface-guidelines/).

## Manually Request a Review

To enable a user to initiate a review as a result of an action in the UI use a deep link to the App Store page for your app with the query parameter `action=write-review` appended to the URL.

``` swift
@IBAction func requestReviewManually() {
    // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
    //       You can find the App Store ID in your app's product URL
    guard let writeReviewURL = URL(string: "https://apps.apple.com/app/idXXXXXXXXXX?action=write-review")
        else { fatalError("Expected a valid URL") }
    UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
}
```
[View in Source](x-source-tag://ManualReviewRequest)
