//
//  UIScrollViewMultiDelegate.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 04.07.2022.
//

import UIKit

final class UIScrollViewMultiDelegate: NSObject, UIScrollViewDelegate {
    private var delegates: [WeakBox<UIScrollViewDelegate>]

    init(delegates: [UIScrollViewDelegate?] = []) {
        self.delegates = delegates
            .compactMap { $0 }
            .map { WeakBox(value: $0) }
    }

    func addDelegate(_ delegate: UIScrollViewDelegate) {
        if delegates.contains(where: { $0.value === delegate }) {
            return
        }

        delegates.append(.init(value: delegate))
    }

    func removeDelegate(_ delegate: UIScrollViewDelegate) {
        delegates = delegates.filter { $0.value !== delegate }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidScroll?(scrollView)
        }
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidZoom?(scrollView)
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewWillBeginDragging?(scrollView)
        }
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegates.forEach {
            $0.value?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegates.forEach {
            $0.value?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewWillBeginDecelerating?(scrollView)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidEndDecelerating?(scrollView)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidEndScrollingAnimation?(scrollView)
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        delegates
            .compactMap {
                $0.value?.viewForZooming?(in: scrollView)
            }
            .first
    }

    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        delegates.forEach {
            $0.value?.scrollViewWillBeginZooming?(scrollView, with: view)
        }
    }

    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        delegates.forEach {
            $0.value?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale)
        }
    }

    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        delegates
            .compactMap {
                $0.value?.scrollViewShouldScrollToTop?(scrollView)
            }
            .first ?? true

    }

    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidScrollToTop?(scrollView)
        }
    }

    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        delegates.forEach {
            $0.value?.scrollViewDidChangeAdjustedContentInset?(scrollView)
        }
    }
}
