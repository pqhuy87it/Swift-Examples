//
//  SimpleFloatingViewController.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 28.06.2022.
//

import UIKit

final class SimpleFloatingViewController: UIViewController {
    weak var floatingSheetController: FloatingSheetViewController?

    private var fullState = FloatingSheetState(id: "full")
    private var mediumState = FloatingSheetState(id: "medium")
    private var minimalState = FloatingSheetState(id: "minimal")

    @IBOutlet
    private var stackView: UIStackView!

    static func create() -> SimpleFloatingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: SimpleFloatingViewController = storyboard.instantiateViewController(identifier: "SimpleFloatingViewController")
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fullState.position = .full()

        mediumState.position = .aboveBottomEdge(relativeHeight: 0.5)
            .inseted(.init(top: 8, left: 8, bottom: 8, right: 8))
        mediumState.appearance.overlayColor = UIColor.black.withAlphaComponent(0.2)
        mediumState.appearance.cornerRadius = 24
        mediumState.appearance.shadow = .init(
            color: .black,
            offset: .zero,
            radius: 4.0,
            opacity: 0.4
        )

        minimalState.position = .aboveBottomEdge(relativeHeight: 0.25)
        minimalState.mask = .aboveView(stackView)
            .inseted(.init(top: -4, left: 0, bottom: 0, right: 0))
    }

    @IBAction
    func switchToFull() {
        floatingSheetController?.setState(fullState, animated: true)
    }

    @IBAction
    func switchToShrink() {
        floatingSheetController?.setState(mediumState, animated: true)
    }

    @IBAction
    func switchToMinimal() {
        floatingSheetController?.setState(minimalState, animated: true)
    }
}

extension SimpleFloatingViewController: FloatingSheetPresentable {
    var floatingStates: [FloatingSheetState] {
        [mediumState,  fullState]
    }
}
