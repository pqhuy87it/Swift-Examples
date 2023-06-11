//
//  FloatingSheetView.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 27.06.2022.
//

import QuartzCore
import UIKit

final class FloatingSheetView: UIView {
    let overlayView: UIView = UIView()
    let floatingView: UIView = UIView()
    let maskingView: UIView = UIView()
    let shadowView: UIView = .init()
    let contentContainer: UIView = UIView()

    private(set) var contentView: UIView?
    var currentState: FloatingSheetState = .default {
        didSet {
            updateScrolling()
        }
    }

    private let panGestureRecognizer = InstantPanGestureRecognizer()
    private var transitionBehaviour = FloatingSheetTransitionBehaviour()
    private var scrollBehaviour = FloatingSheetScrollingBehaviour()

    var shouldUpdateAfterLayout: Bool = true
    var shouldInterceptTap: Bool {
        get {
            panGestureRecognizer.shouldInterceptTap
        }
        set {
            panGestureRecognizer.shouldInterceptTap = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = .clear

        overlayView.frame = bounds
        addSubview(overlayView)
        overlayView.edgesToSuperview()

        floatingView.clipsToBounds = false
        floatingView.insertSubview(shadowView, belowSubview: contentContainer)

        maskingView.frame = contentContainer.bounds
        maskingView.backgroundColor = .white
        contentContainer.mask = maskingView

        floatingView.addSubview(contentContainer)

        addSubview(floatingView)
        panGestureRecognizer.addTarget(self, action: #selector(didPanFloatingView(recognizer:)))
        floatingView.addGestureRecognizer(panGestureRecognizer)

        transitionBehaviour.view = self
        transitionBehaviour.scrollingBehaviour = scrollBehaviour

        scrollBehaviour.view = self
        scrollBehaviour.transitionBehaviour = transitionBehaviour

        updateUI(to: currentState)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if shouldUpdateAfterLayout {
            shouldUpdateAfterLayout = false
            updateUI(to: currentState)
        }
    }

    func setContent(_ contentView: UIView) {
        self.contentView?.removeFromSuperview()
        self.contentView = contentView
        contentContainer.addSubview(contentView)
        updateUI(to: currentState)
    }

    func setStates(_ states: [FloatingSheetState]) {
        transitionBehaviour.states = states
    }

    func setCurrentState(_ state: FloatingSheetState, animated: Bool) {
        if animated {
            transitionBehaviour.setStateAnimated(to: state)
        } else {
            currentState = state
            updateUI(to: state)
        }
    }

    func updateUI(to state: FloatingSheetState?) {
        let updater = FloatingSheetUpdater(sheetView: self, to: state)
        updater?.update()
    }

    func currentContext() -> FloatingSheetContext? {
        guard let contentView = contentView else {
            return nil
        }

        let context = FloatingSheetContext(
            availableSize: overlayView.bounds.size,
            contentView: contentView
        )

        return context
    }

    func setFloatingScrollView(_ scrollView: UIScrollView?) {
        scrollBehaviour.setFloatingScrollView(scrollView)
    }

    func gesture(for recognizer: UIPanGestureRecognizer) -> Gesture {
        let translation = recognizer.translation(in: self)
        let velocity = recognizer.velocity(in: self)
        let gesture = Gesture(translation: translation, velocity: velocity)
        return gesture
    }

    @objc private func didPanFloatingView(recognizer: UIPanGestureRecognizer) {
        let gesture = self.gesture(for: recognizer)
        transitionBehaviour.didPan(state: recognizer.state, gesture: gesture)
    }

    private func updateScrolling() {
        scrollBehaviour.setScrollingEnabled(currentState.interaction.enableScrolling)
    }
}
