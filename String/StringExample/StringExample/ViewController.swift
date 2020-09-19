//
//  ViewController.swift
//  StringExample
//
//  Created by Pham Quang Huy on 2020/09/07.
//  Copyright © 2020 Pham Quang Huy. All rights reserved.
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
        items = ["Superscript Styling",
				 "Json String"]
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
            let storyBoard = UIStoryboard(name: "Superscript", bundle: nil)
            if let superScriptVC = storyBoard.instantiateViewController(withIdentifier: "SuperscriptViewController") as? SuperscriptViewController {
                self.navigationController?.pushViewController(superScriptVC, animated: true)
            }
		case 1:
			let storyBoard = UIStoryboard(name: "JsonFromString", bundle: nil)
			if let jsonFromStringVC = storyBoard.instantiateViewController(identifier: "JSONFromStringViewController") as? JSONFromStringViewController {
				self.navigationController?.pushViewController(jsonFromStringVC, animated: true)
			}
            default:
            break
        }
    }
}
