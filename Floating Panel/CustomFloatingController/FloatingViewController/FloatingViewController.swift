//
//  FloatingViewController.swift
//  FloatingViewController
//
//  Created by yusuf demirkoparan on 5.10.2021.
//

import UIKit


protocol FloatingViewControllerDelegateProtocol where Self: UIViewController {
    func viewDissmisModeIsEnable() -> Bool
    func viewContentHeight() -> CGFloat
    func viewExpandedHeight() -> CGFloat
    func viewClosedHeight() -> CGFloat
    func didChangedViewState(changed state: FloatingViewState)
    func changeViewMode(with mode: FloatingViewState)
    func dismiss(_ didFinish: () -> Void)
}

extension FloatingViewControllerDelegateProtocol {
    func viewExpandedHeight() -> CGFloat {
        return 0
    }
    
    func viewClosedHeight() -> CGFloat {
        return 0
    }
    
    func didChangedViewState(changed state: FloatingViewState) {}
    func changeViewMode(with mode: FloatingViewState) {}
    func dismiss(_ didFinish: () -> Void) {}
}

enum FloatingViewState {
    case expanded
    case collapsed
    case closed
}

protocol FloatingViewControllerAnimationDelegate: AnyObject {
    func startAnimation()
    func startInteractiveTransition(state: FloatingViewState, duration: TimeInterval)
    func animateTransitionIfNeeded(state: FloatingViewState, duration: TimeInterval)
    func updateInteractiveTransition(fractionCompleted: CGFloat)
    func continueInteractiveTransition()
}


class FloatingViewController: UIViewController {
    
    var floatingViewStateChanged : (_ state : FloatingViewState) -> () = { state in }
    
    weak var delegate: FloatingViewControllerDelegateProtocol?
    private var isFirst = true
    private var visualEffectView: UIVisualEffectView!
    private var floatingViewController: UIViewController!
    private var viewContentHeight: CGFloat = 0
    private var viewClosedModeTopConstant: CGFloat = 0
    private var viewTopConstant: CGFloat = 0
    private var keyboardState: Bool = false
    private var viewDissmisModeIsEnable: Bool = false
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted: CGFloat = 0
    private var currentState: FloatingViewState = .collapsed {
        didSet {
            delegate?.didChangedViewState(changed: currentState)
        }
    }
    
    lazy var floatingIcon: UIImageView = {
        var imgView = UIImageView(frame: .zero)
        let img = UIImage(named: "line")
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if floatingViewController != nil && isFirst{
            isFirst = false
            setHeight()
            startAnimation()
        }
    }
    
    private func setupFloatingViewUI() {
     //   floatingViewController.view.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        floatingIcon.translatesAutoresizingMaskIntoConstraints = false
        floatingViewController.view.addSubview(floatingIcon)
        floatingIcon.topAnchor.constraint(equalTo: floatingViewController.view.topAnchor, constant: 8).isActive = true
        floatingIcon.centerXAnchor.constraint(equalTo: floatingViewController.view.centerXAnchor).isActive = true
        floatingIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        floatingIcon.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    func setup(_ contentViewController: FloatingViewControllerDelegateProtocol) {
        delegate = contentViewController
        floatingViewController = contentViewController
        setupFloatingView()
        view.bringSubviewToFront(floatingViewController.view)
        setupFloatingViewUI()
    }
    
    private func setupFloatingView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        visualEffectView.isUserInteractionEnabled = false
        view.addSubview(visualEffectView)
        
        addChild(floatingViewController)
        view.addSubview(floatingViewController.view)
        floatingViewController.view.clipsToBounds = true
        setHeight()
        
        let tapGestureSelector: Selector = #selector(FloatingViewController.handleFloatingViewTap(recognzier:))
        let panGestureSelector: Selector = #selector(FloatingViewController.handleFloatingViewPan(recognizer:))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: tapGestureSelector)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: panGestureSelector)
       // view.addGestureRecognizer(tapGestureRecognizer)
        floatingViewController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func dismiss(_ didFinish: () -> Void = { }) {
        currentState = .closed
        animateTransitionIfNeeded(state: currentState, duration: 0.9)
        didFinish()
        delegate?.dismiss(didFinish)
    }
    
    func refreshHeight() {
        if let visibleHeight = delegate?.viewContentHeight() {
            viewContentHeight = visibleHeight
            var frame = floatingViewController.view.frame
            
            let frameAnimator = UIViewPropertyAnimator.init(duration: 0.8, dampingRatio: 0.7) {
                frame.origin.y = self.view.frame.size.height - self.viewContentHeight
                frame.size.height = self.viewContentHeight
                frame.size.width = self.view.frame.size.width
                self.floatingViewController.view.frame = frame
            }
            frameAnimator.startAnimation()
        }
    }
    
    private func setHeight() {
        if let storngDelegate = delegate {
            viewContentHeight = storngDelegate.viewContentHeight()
            viewTopConstant = storngDelegate.viewExpandedHeight()
            viewClosedModeTopConstant = storngDelegate.viewClosedHeight()
            viewDissmisModeIsEnable = storngDelegate.viewDissmisModeIsEnable()
            floatingViewController.view.frame = CGRect(x: 0,
                                                       y: view.frame.size.height,
                                                       width: view.bounds.width,
                                                       height: viewContentHeight)
        }
    }
    
    deinit {
        print("deinit \(self.classForCoder)")
    }
}

// MARK: - Recognizers
extension FloatingViewController {
    @objc private func handleFloatingViewTap(recognzier: UITapGestureRecognizer) {
        dismissKeyboard()
        switch recognzier.state {
        case .ended:
            if viewDissmisModeIsEnable {
                self.dismiss()
            }
        default:
            break
        }
    }
    
    @objc private func handleFloatingViewPan (recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        _ = recognizer.location(in: self.view)
        
        switch recognizer.state {
        case .began:
            checkscrollDirection(check: recognizer.verticalDirection(with: self.view))
        case .changed:
            var fractionComplete = translation.y / viewContentHeight
            fractionComplete = -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    private func checkscrollDirection(check direction: UIPanGestureRecognizer.GestureDirection) {
        switch direction {
        case .Down:
            let state: FloatingViewState = currentState == .collapsed
            ? .closed
            : .collapsed
            let duration = state == .closed ? 0.9 : 0.9
            startInteractiveTransition(state: state, duration: duration)
        case .Up:
            let state: FloatingViewState = currentState == .closed
            ? .collapsed
            : .expanded
            startInteractiveTransition(state: state, duration: 0.9)
        default: break
        }
    }
}

// MARK: - Animation
extension FloatingViewController: FloatingViewControllerAnimationDelegate {
    internal func startAnimation() {
        let frameAnimator = UIViewPropertyAnimator(duration: 0.8, dampingRatio: 0.8) {
            self.floatingViewController.view.frame.origin.y = self.view.frame.height - self.viewTopConstant
        }
        
        frameAnimator.addCompletion { (position) in
            if position == .end {
                // TODO: -
            }
        }
        frameAnimator.startAnimation()
    }
    
    internal func animateTransitionIfNeeded(state: FloatingViewState, duration: TimeInterval) {
        if runningAnimations.isEmpty {
            let viewAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
                switch state {
                case .expanded:
                    self.floatingViewController.view.frame.origin.y = self.view.frame.height - self.viewContentHeight
                case .collapsed:
                    self.floatingViewController.view.frame.origin.y = self.view.frame.height - self.viewTopConstant
                case .closed:
                    self.floatingViewController.view.frame.origin.y = self.view.frame.height - self.viewClosedModeTopConstant
                }
            }
            
            let blurAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .extraLight)
                    
                case .collapsed, .closed:
                    self.visualEffectView.effect = nil
                }
            }
            
            viewAnimation.addCompletion { _ in
                self.runningAnimations.removeAll()
                self.floatingViewStateChanged(state)
            }
            
            viewAnimation.startAnimation()
            blurAnimation.startAnimation()
            runningAnimations.append(viewAnimation)
            runningAnimations.append(blurAnimation)
        }
    }
    
    internal func startInteractiveTransition(state: FloatingViewState, duration: TimeInterval) {
        currentState = state
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    internal func updateInteractiveTransition(fractionCompleted: CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    internal func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    func changeViewMode(with mode: FloatingViewState) {
        delegate?.changeViewMode(with: mode)
        animateTransitionIfNeeded(state: mode, duration: 0.9)
    }
}

// MARK: - Keyboard
fileprivate extension FloatingViewController {
    func setupKeyboardState() {
        _ = #selector(keyboardWillAppear)
    }
    
    func dismissKeyboard() {
        floatingViewController.view.endEditing(true)
        if keyboardState {
            currentState = .collapsed
            animateTransitionIfNeeded(state: currentState, duration: 0.9)
            keyboardState = !keyboardState
        }
    }
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        keyboardState = !keyboardState
        currentState = .expanded
        animateTransitionIfNeeded(state: currentState, duration: 0.9)
    }
}




extension UIPanGestureRecognizer {

    enum GestureDirection {
        case Up
        case Down
        case Left
        case Right
    }

    /// Get current vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func verticalDirection(with target: UIView) -> GestureDirection {
        return self.velocity(in: target).y > 0 ? .Down : .Up
    }

    /// Get current horizontal direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func horizontalDirection(with target: UIView) -> GestureDirection {
        return self.velocity(in: target).x > 0 ? .Right : .Left
    }

    /// Get a tuple for current horizontal/vertical direction
    ///
    /// - Parameter target: view target
    /// - Returns: current direction
    func versus(with target: UIView) -> (horizontal: GestureDirection, vertical: GestureDirection) {
        return (self.horizontalDirection(with: target), self.verticalDirection(with: target))
    }

}

extension UIViewController {
    func showFloatingViewController<T, U>(with contentViewController : T, with mainViewController: U) where T: FloatingViewControllerDelegateProtocol, U: FloatingViewController {
        mainViewController.setup(contentViewController)
        self.addChild(contentViewController)
        self.view.addSubview(contentViewController.view)
        mainViewController.didMove(toParent: self)
        mainViewController.view.frame = self.view.frame
        mainViewController.floatingViewStateChanged = { item in
            print("FloatingViewController State : \(item)")
        }
    }
}
