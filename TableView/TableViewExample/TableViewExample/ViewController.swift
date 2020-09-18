//
//  ViewController.swift
//  TableViewExample
//
//  Created by iMac07 on 2020/09/13.
//  Copyright © 2020 Huy Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var items: [String] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		self.setupUI()
		self.setupData()
	}

	func setupUI() {
		tableView.registerCellByNib(TableViewCell.self)
	}
	
	func setupData() {
		items = ["Animating Header.","Collapsible Section"]
	}
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueCell(TableViewCell.self, forIndexPath: indexPath) else {
			return UITableViewCell()
		}
		
		cell.titleLb.text = self.items[indexPath.row]
		
		return cell
	}
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.row {
		case 0:
            if let animatingHeaderVC = AnimatingHeaderViewController.fromStoryboard(Storyboards.AnimatingHeader.name) as? AnimatingHeaderViewController {
                self.navigationController?.pushViewController(animatingHeaderVC, animated: true)
            }
			break
        case 1:
            if let collapsibleSectionVC = CollapsibleTableViewController.fromStoryboard(Storyboards.CollapsibleSection.name) as? CollapsibleTableViewController {
                self.navigationController?.pushViewController(collapsibleSectionVC, animated: true)
            }
		default:
			break
		}
	}
}
