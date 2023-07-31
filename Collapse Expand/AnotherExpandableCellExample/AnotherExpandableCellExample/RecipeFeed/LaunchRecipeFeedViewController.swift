//
//  LaunchRecipeFeedViewController.swift
//  AnotherExpandableCellExample
//
//  Created by Don Mag on 5/21/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

class LaunchRecipeFeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	
	@IBAction func didTap(_ sender: Any) {

		let vc = RecipeTableView(nibName: "RecipeTableView", bundle: nil)
		navigationController?.pushViewController(vc, animated: true)

	}
	
}
