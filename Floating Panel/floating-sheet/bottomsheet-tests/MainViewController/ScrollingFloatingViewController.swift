//
//  ScrollingFloatingViewController.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 04.07.2022.
//

import UIKit

final class ScrollingFloatingViewController: UIViewController {

    static func create() -> ScrollingFloatingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController: ScrollingFloatingViewController = storyboard.instantiateViewController(identifier: "ScrollingFloatingViewController")
        return viewController
    }

    weak var floatingSheetController: FloatingSheetViewController?

    @IBOutlet private var scrollView: UIScrollView!

    private var minimalState = FloatingSheetState(id: "minimal")
    private var maximalState = FloatingSheetState(id: "maximal")
    

    override func viewDidLoad() {
        scrollView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        scrollView.showsVerticalScrollIndicator = false

        minimalState.position = .aboveBottomEdge(relativeHeight: 0.25)
        minimalState.interaction.enableScrolling = false

        maximalState.position = .full()
    }
}

extension ScrollingFloatingViewController: FloatingSheetPresentable {
    var floatingStates: [FloatingSheetState] {
        [minimalState, maximalState]
    }

    var floatingScrollView: UIScrollView? {
        scrollView
    }
}
