//
//  PullToRefreshView.swift
//  Yep
//
//  Created by NIX on 15/4/14.
//  Copyright (c) 2015年 Catch Inc. All rights reserved.
//

import UIKit

protocol PullToRefreshViewDelegate: class {
    func pulllToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView)
    func scrollView() -> UIScrollView
}

private let sceneHeight: CGFloat = 50.0

final class PullToRefreshView: UIView {
    
//    var refreshView: YepRefreshView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var progressPercentage: CGFloat = 0

    weak var delegate: PullToRefreshViewDelegate?

    var refreshItems = [RefreshItem]()

    var isRefreshing = false {
        didSet {
            if !isRefreshing {
                refreshTimeoutTimer?.invalidate()
            }
        }
    }

    var refreshTimeoutTimer: Timer?

    var refreshTimeoutAction: (() -> Void)? {
        didSet {
            refreshTimeoutTimer?.invalidate()
            refreshTimeoutTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(PullToRefreshView.refreshTimeout(_:)), userInfo: nil, repeats: false)
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        self.clipsToBounds = true
//
//        setupRefreshItems()
//
//        updateColors()
    }

    func setupRefreshItems() {
//        
//        refreshView = YepRefreshView(frame: CGRectMake(0, 0, 50, 50))
//
//        refreshItems = [
//            RefreshItem(
//                view: refreshView,
//                centerEnd: CGPoint(
//                    x: CGRectGetMidX(UIScreen.mainScreen().bounds),
//                    y: 200 - sceneHeight * 0.5
//                ),
//                parallaxRatio: 0,
//                sceneHeight: sceneHeight
//            ),
//        ]
//
//        for refreshItem in refreshItems {
//            addSubview(refreshItem.view)
//        }
        let activityIndeicatorView = UIActivityIndicatorView()
//        activityIndeicatorView.center = self.center
        activityIndeicatorView.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2, width: 40, height: 40)
        activityIndeicatorView.style = .gray
//        activityIndeicatorView.isAnimating
        addSubview(activityIndeicatorView)
    }

    func updateColors() {
//        refreshView.updateShapePositionWithProgressPercentage(progressPercentage)
    }

    func updateRefreshItemPositions() {
        for refreshItem in refreshItems {
            refreshItem.updateViewPositionForPercentage(progressPercentage)
        }
    }

    // MARK: Actions

    func beginRefreshing() {

        isRefreshing = true
        
        activityIndicator.startAnimating()

        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
            self?.delegate?.scrollView().contentInset.top += sceneHeight
        }, completion: nil)
    }

    func endRefreshingAndDoFurtherAction(furtherAction:  @escaping () -> Void) {

        guard isRefreshing else {
            return
        }

        isRefreshing = false
        activityIndicator.stopAnimating()

        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.delegate?.scrollView().contentInset.top -= sceneHeight

        }, completion: { finished in 

            furtherAction()
            
        })
    }

    @objc func refreshTimeout(_ timer: Timer) {
        print("PullToRefreshView refreshTimeout")
        refreshTimeoutAction?()
    }
}

extension PullToRefreshView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        if isRefreshing {
            return
        }

        let refreshViewVisibleHeight = max(0, -(scrollView.contentOffset.y + scrollView.contentInset.top))
        progressPercentage = min(1, refreshViewVisibleHeight / sceneHeight)

        updateRefreshItemPositions()

        updateColors()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        if !isRefreshing && progressPercentage == 1 {

            beginRefreshing()

            targetContentOffset.pointee.y = -scrollView.contentInset.top

            delegate?.pulllToRefreshViewDidRefresh(self)
        }
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        if !isRefreshing && progressPercentage == 1 {

            beginRefreshing()

            scrollView.contentOffset.y = -scrollView.contentInset.top

            delegate?.pulllToRefreshViewDidRefresh(self)
        }
    }
}

final class RefreshItem {

    unowned var view: UIView

    private var centerStart: CGPoint
    private var centerEnd: CGPoint

    init(view: UIView, centerEnd: CGPoint, parallaxRatio: CGFloat, sceneHeight: CGFloat) {
        self.view = view
        self.centerEnd = centerEnd

        centerStart = CGPoint(x: centerEnd.x, y: centerEnd.y + (parallaxRatio * sceneHeight))
        self.view.center = centerStart
    }

    func updateViewPositionForPercentage(_ percentage: CGFloat) {
        view.center = CGPoint(
            x: centerStart.x + (centerEnd.x - centerStart.x) * percentage,
            y: centerStart.y + (centerEnd.y - centerStart.y) * percentage
        )
    }

    func updateViewTintColor(tintColor: UIColor) {
        view.tintColor = tintColor
    }
}
