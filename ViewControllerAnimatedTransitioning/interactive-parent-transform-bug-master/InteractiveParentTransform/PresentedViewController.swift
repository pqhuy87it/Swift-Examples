//
//  PresentedViewController.swift
//  InteractiveParentTransform
//
//  Created by Brian Nickel on 4/20/16.
//  Copyright © 2016 Stack Exchange. All rights reserved.
//

import UIKit

class PresentedViewController: UIViewController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private var interactiveTransitioning:UIPercentDrivenInteractiveTransition? = nil
    
    @IBAction private func panned(sender : UIPanGestureRecognizer) {
        
        switch sender.state {
            case .began:
            interactiveTransitioning = UIPercentDrivenInteractiveTransition()
            performSegue(withIdentifier: "unwind", sender: self)
            case .changed:
                interactiveTransitioning?.update(sender.translation(in: view.superview).y / view.bounds.height)
            case .cancelled:
            interactiveTransitioning?.cancel()
            interactiveTransitioning = nil
            case .ended:
                if sender.velocity(in: view.superview).y > 0 {
                interactiveTransitioning?.finish()
            } else {
                interactiveTransitioning?.cancel()
            }
            interactiveTransitioning = nil
        default:
            break
        }
    }
}

extension PresentedViewController : UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomDismissAnimatedTransitioning()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransitioning
    }
}

class CustomPresentationController : UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let frame = super.frameOfPresentedViewInContainerView
        let insets = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        return frame.inset(by: insets)
    }
    
    private func setScale(expanded: Bool) {
        
        if expanded {
            let fromMeasurement = presentingViewController.view.bounds.width
            let fromScale = (fromMeasurement - 30) / fromMeasurement
            presentingViewController.view.transform = CGAffineTransform(scaleX: fromScale, y: fromScale)
        } else {
            presentingViewController.view.transform = CGAffineTransform.identity
        }
        
    }
    
    override func presentationTransitionWillBegin() {
        
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.setScale(expanded: true)
        }, completion: { context in
            self.setScale(expanded: !context.isCancelled)
        })
    }
    
    override func dismissalTransitionWillBegin() {
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.setScale(expanded: false)
        }, completion: { context in
            self.setScale(expanded: context.isCancelled)
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let bounds = containerView?.bounds else { return }
        presentingViewController.view.bounds = bounds
    }
}

class CustomDismissAnimatedTransitioning : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let duration = transitionDuration(using: transitionContext)
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let initialFrame = transitionContext.initialFrame(for: fromViewController)
        var finalFrame = initialFrame
        
        finalFrame.origin.y = initialFrame.maxY
        
        fromViewController.view.frame = initialFrame
        transitionContext.containerView.addSubview(fromViewController.view)
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            fromViewController.view.frame = finalFrame
        }, completion: { _ in
            if transitionContext.transitionWasCancelled {
                transitionContext.completeTransition(false)
            } else {
                fromViewController.view.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        })
    }
}
