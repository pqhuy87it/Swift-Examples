//
//  FloatingSheetScrollingBehaviour.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 04.07.2022.
//

import UIKit

final class FloatingSheetScrollingBehaviour: NSObject {

    weak var transitionBehaviour: FloatingSheetTransitionBehaviour?
    weak var view: FloatingSheetView?

    private(set) var isTransitioningInsteadScrolling: Bool = false

    private weak var floatingScrollView: UIScrollView?
    private var floatingScrollViewDelegate = UIScrollViewMultiDelegate()
    private var lastScrollingGesture: Gesture?

    func setFloatingScrollView(_ scrollView: UIScrollView?) {
        if
            let existingScrollView = floatingScrollView,
            existingScrollView.delegate === floatingScrollViewDelegate
        {
            existingScrollView.delegate = nil
        }

        floatingScrollView = scrollView

        if let scrollView = scrollView {
            floatingScrollViewDelegate = .init(delegates: [scrollView.delegate, self])
            scrollView.delegate = floatingScrollViewDelegate
        }
    }

    func setScrollingEnabled(_ isScrollingEnabled: Bool) {
        floatingScrollView?.isScrollEnabled = isScrollingEnabled
    }
}

// MARK: - Transitioning
extension FloatingSheetScrollingBehaviour {

    private func startTransitionInsteadScrollingIfNeeded(gesture: Gesture) {
        guard shouldTransitioningInsteadOfScrolling(for: gesture) else { return }

        isTransitioningInsteadScrolling = true
        transitionBehaviour?.didPan(state: .began, gesture: gesture)
        print("FloatingSheetScrollingBehaviour.startTransitionInsteadScrolling")
    }

    private func continueTransitionInsteadScrolling(gesture: Gesture, preventScrolling: Bool) {
        guard isTransitioningInsteadScrolling else { return }
        guard let scrollView = floatingScrollView else { return }

        transitionBehaviour?.didPan(state: .changed, gesture: gesture)

        if preventScrolling {
            var offset = scrollView.contentOffset
            offset.y = -scrollView.adjustedContentInset.top
            scrollView.setContentOffset(offset, animated: false)
        }

        print("FloatingSheetScrollingBehaviour.continueTransitionInsteadScrolling")
    }

    private func finishTransitionInsteadScrolling() {
        guard isTransitioningInsteadScrolling else { return }
        if let lastScrollingGesture = lastScrollingGesture {
            transitionBehaviour?.didPan(state: .ended, gesture: lastScrollingGesture)
        }
        isTransitioningInsteadScrolling = false
        lastScrollingGesture = nil
    }

    private func shouldTransitioningInsteadOfScrolling(for gesture: Gesture) -> Bool {
        guard
            let scrollView = floatingScrollView,
            let transitionBehaviour = transitionBehaviour
        else { return false }

        if transitionBehaviour.isTransitioning {
            return true
        }

        if scrollView.contentOffset.y > -scrollView.adjustedContentInset.top {
            // If content is already scrolled we allow user to scroll back
            return false
        }

        return transitionBehaviour.haveTransition(for: gesture)
    }
}

// MARK: - UIScrollViewDelegate
extension FloatingSheetScrollingBehaviour: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let view = view else { return }

        let scrollingGesture = view.gesture(for: scrollView.panGestureRecognizer)
        startTransitionInsteadScrollingIfNeeded(gesture: scrollingGesture)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let view = view else { return }

        let scrollingGesture = view.gesture(for: scrollView.panGestureRecognizer)

        if isTransitioningInsteadScrolling {
            continueTransitionInsteadScrolling(gesture: scrollingGesture, preventScrolling: true)
        } else {
            startTransitionInsteadScrollingIfNeeded(gesture: scrollingGesture)
        }

        lastScrollingGesture = scrollingGesture
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("FloatingSheetScrollingBehaviour.scrollViewWillEndDragging() isTransitioningInsteadScrolling = \(isTransitioningInsteadScrolling)")
        if isTransitioningInsteadScrolling {
            targetContentOffset.pointee = scrollView.contentOffset
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("FloatingScrollingBehaviour.didEndDragging(willDecelerate: \(decelerate))")
        finishTransitionInsteadScrolling()
    }
}
