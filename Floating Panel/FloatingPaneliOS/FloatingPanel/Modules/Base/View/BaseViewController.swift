//
//  ViewController.swift
//  FloatingPanel
//
//  Created by Azhar Ragab on 06/02/2023.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var btnShowPanel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    init() {
        super.init(nibName: String(describing: Self.self),
                   bundle: .init(for: Self.self))
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func setUpView() {
        btnShowPanel.layer.cornerRadius = 0.5 * btnShowPanel.bounds.size.width
        btnShowPanel.clipsToBounds = true
    }

    @IBAction func showPanel(_ sender: Any) {
        let vc = BottomSheetContainerViewController(bottomSheetViewController: DetailsViewController(), bottomSheetConfiguration: .init(
                height: UIScreen.main.bounds.height * 0.9,
                initialOffset: UIScreen.main.bounds.height / 2
            ))
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
}

