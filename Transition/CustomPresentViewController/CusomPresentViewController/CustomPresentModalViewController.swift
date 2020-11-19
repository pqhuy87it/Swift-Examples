//
//  CustomPresentModalViewController.swift
//  CusomPresentViewController
//
//  Created by Exlinct on 11/26/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class CustomPresentModalViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.setRounded()
        }
    }
    
    let transition = CustomPresentModalAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    @IBAction func buttonPressed(sender: AnyObject) {
        let avatarViewController = self.storyboard!.instantiateViewController(withIdentifier: "avatarViewControllere") as! AvatarViewController
        avatarViewController.transitioningDelegate = self
        avatarViewController.modalPresentationStyle = .custom
        self.present(avatarViewController, animated: true, completion: nil)
    }
    
}

extension CustomPresentModalViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController,
                                                   presentingController presenting: UIViewController,
                                                                        sourceController source: UIViewController) ->
        UIViewControllerAnimatedTransitioning? {
            self.view.layoutSubviews()
            self.view.layoutIfNeeded()
            
            transition.presenting = true
        transition.originFrame = avatarImageView.superview!.convert(avatarImageView!.frame, to: nil)
            return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
