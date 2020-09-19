//
//  ViewController.swift
//  Animations
//
//  Created by Pham Quang Huy on 12/11/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 150.0
            
        }
    }
    var items = ["View Animation"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
}

extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        let item = items[indexPath.row]
        cell.nameLabel.text = item
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewAnimationController") as! ViewAnimationController
            self.navigationController?.pushViewController(viewController, animated: true)
        case 1:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewAnimationController") as! ViewAnimationController
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}

