//
//  ViewController.swift
//  bottomsheet-tests
//
//  Created by Vladislav Maltsev on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBAction
    private func openBottomSheet() {
        let viewController = SimpleFloatingViewController.create()
        let bottomSheet = FloatingSheetViewController(contentController: viewController)
        present(bottomSheet, animated: true)
    }

    @IBAction
    private func openScrollingBottomSheet() {
        let viewController = ScrollingFloatingViewController.create()
        let bottomSheet = FloatingSheetViewController(contentController: viewController)
        present(bottomSheet, animated: true)
    }
}

