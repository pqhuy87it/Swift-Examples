//
//  UIView+TinyConstraints.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

extension UIView {
    func edgesToSuperview() {
        leadingToSuperview()
        trailingToSuperview()
        topToSuperview()
        bottomToSuperview()
    }

    func leadingToSuperview() {
        guard let superview = superview else { return }
        leading(to: superview)
    }

    func leading(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }

    func trailingToSuperview(priority: UILayoutPriority = .required) {
        guard let superview = superview else { return }
        trailing(to: superview, priority: priority)
    }

    func trailing(to view: UIView, priority: UILayoutPriority = .required) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(equalTo: view.trailingAnchor)
        constraint.priority = priority
        NSLayoutConstraint.activate([
            constraint
        ])
    }

    func topToSuperview() {
        guard let superview = superview else { return }
        top(to: superview)
    }

    func top(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }

    func bottomToSuperview(prority: UILayoutPriority = .required) {
        guard let superview = superview else { return }
        bottom(to: superview, priority: prority)
    }

    func bottom(to view: UIView, priority: UILayoutPriority = .required) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraint.priority = priority
        NSLayoutConstraint.activate([
            constraint
        ])
    }
}
