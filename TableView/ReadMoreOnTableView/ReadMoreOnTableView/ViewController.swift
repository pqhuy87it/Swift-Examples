//
//  ViewController.swift
//  ReadMoreOnTableView
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Huy Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var maxCharacterCount = 100

    var isFullContent = false
    var items = ["Lorem ipsum dolor sit er elit lamet",
                 "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UINib(nibName: "ReadMoreCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100.0
    }

    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ReadMoreCell
        let item = items[indexPath.row]
        cell.selectionStyle = .none
        
        if item.count > maxCharacterCount && !isFullContent {
            let startIndex = item.startIndex
            let indext = item.index(startIndex, offsetBy: maxCharacterCount)
            var subText = item.substring(to: indext)
            subText += "..." + " Read more."
            cell.messageLabel.text = subText
            
            let range = (subText as NSString).range(of: " Read more.")
            cell.messageLabel.delegate = self
            cell.messageLabel.linkAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            cell.messageLabel.addLink(toTransitInformation: ["Value": "Read More"], with: range)

            
            return cell
        }
        
         cell.messageLabel.text = item
        return cell
    }
}

extension ViewController: TTTAttributedLabelDelegate {
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWithTransitInformation components: [AnyHashable : Any]!) {
        if let value = components["Value"] as? String, value == "Read More" {
            isFullContent = true
            tableView.reloadData()
        }
    }
}
