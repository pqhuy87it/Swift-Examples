//
//  BottomSheetViewController.swift
//  FloatingPanel
//
//  Created by Azhar Ragab on 07/02/2023.
//

import UIKit

class BottomSheetContainerViewController<BottomSheet: UIViewController>: UIViewController, UIGestureRecognizerDelegate {

    private let configuration: BottomSheetConfiguration
    var state: BottomSheetState = .collapsed

    let bottomSheetViewController: BottomSheet

    private var topConstraint = NSLayoutConstraint()

    lazy var panGesture: UIPanGestureRecognizer = {
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        pan.addTarget(self, action: #selector(handlePan))
        return pan
    }()

    init(bottomSheetViewController: BottomSheet,
        bottomSheetConfiguration: BottomSheetConfiguration) {

        self.bottomSheetViewController = bottomSheetViewController
        self.configuration = bottomSheetConfiguration

        super.init(nibName: nil, bundle: nil)
        self.setupUI()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    private func setupUI() {
        bottomSheetViewController.view.makeCorner(withRadius: 20)
        self.addChild(bottomSheetViewController)
        self.view.addSubview(bottomSheetViewController.view)
        bottomSheetViewController.view.addGestureRecognizer(panGesture)
        bottomSheetViewController.view.translatesAutoresizingMaskIntoConstraints = false

        topConstraint = bottomSheetViewController.view.topAnchor
            .constraint(equalTo: self.view.bottomAnchor,
            constant: -configuration.initialOffset)

        NSLayoutConstraint.activate([
            bottomSheetViewController.view.heightAnchor
                .constraint(equalToConstant: configuration.height),
            bottomSheetViewController.view.leftAnchor
                .constraint(equalTo: self.view.leftAnchor),
            bottomSheetViewController.view.rightAnchor
                .constraint(equalTo: self.view.rightAnchor),
            topConstraint
            ])

        bottomSheetViewController.didMove(toParent: self)
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: bottomSheetViewController.view)
        let velocity = sender.velocity(in: bottomSheetViewController.view)

        let yTranslationMagnitude = translation.y.magnitude

        switch sender.state {
        case .began, .changed:
            if self.state == .expanded {

                guard translation.y > 0 else { return }
                topConstraint.constant = -(configuration.height - yTranslationMagnitude)
                self.view.layoutIfNeeded()
            } else {
                let newConstant = -(configuration.initialOffset + yTranslationMagnitude)
                guard translation.y < 0 else { return }
                guard newConstant.magnitude < configuration.height else {
                    self.expandBottomSheet()
                    return
                }
                topConstraint.constant = newConstant
                self.view.layoutIfNeeded()
            }
        case .ended:
            if self.state == .expanded {

                if velocity.y < 0 {
                    self.expandBottomSheet()
                } else if yTranslationMagnitude >= configuration.height / 2 || velocity.y > 1000 {
                    self.collapseBottomSheet()
                } else {
                    self.expandBottomSheet()
                }
            } else {

                if yTranslationMagnitude >= configuration.height / 2 || velocity.y < -1000 {
                    self.expandBottomSheet()
                } else {
                    self.hideBottomSheet()
                }
            }
        case .failed:
            if self.state == .expanded {
                self.expandBottomSheet()
            } else {
                self.collapseBottomSheet()
            }
        default: break
        }
    }
  
    func expandBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.height

        if animated {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                    self.state = .expanded
                })
        } else {
            self.view.layoutIfNeeded()
            self.state = .expanded
        }
    }

    func collapseBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = -configuration.initialOffset

        if animated {
            UIView.animate(withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseOut],
                animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.state = .collapsed
                })
        } else {
            self.view.layoutIfNeeded()
            self.state = .collapsed
        }
    }

    func hideBottomSheet(animated: Bool = true) {
        self.topConstraint.constant = 0

        if animated {
            UIView.animate(withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.5,
                options: [.curveEaseInOut],
                animations: {
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.state = .hidden
                    self.dismiss(animated: true)
                })
        } else {
            self.view.layoutIfNeeded()
            self.state = .hidden
        }
    }
}
