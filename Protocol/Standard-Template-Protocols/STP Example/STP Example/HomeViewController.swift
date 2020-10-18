//
//  HomeViewController.swift
//  STP Example
//
//  Created by Chris O'Neil on 10/22/15.
//  Copyright © 2015 Because. All rights reserved.
//

import UIKit

enum GestureRecognizerType:Int {
    case Moveable
    case Pinchable
    case Rotatable
    case Tappable
    case Forceable

    func name() -> String {
        switch self {
        case .Moveable:
            return "Moveable"
        case .Pinchable:
            return "Pinchable"
        case .Rotatable:
            return "Rotatable"
        case .Tappable:
            return "Tappable"
        case .Forceable:
            return "Forceable"
        }
    }
}

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    let cellIdentifier = "HomeTableViewCellIdentifier"
    let headerFooterIdentifier = "HomeTableViewHeaderFooterViewIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Choose a Gesture Protocol"

        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.allowsMultipleSelection = true
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()

        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(didTapNext))
        self.navigationItem.rightBarButtonItem = nextButton
     }

    // MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: self.cellIdentifier)
        }
        cell!.textLabel?.text = GestureRecognizerType(rawValue: indexPath.row)?.name()
        cell!.selectionStyle = .none;
        return cell!
    }

    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    // MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableViewCell = self.tableView.cellForRow(at: indexPath)
        tableViewCell?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let tableViewCell = self.tableView.cellForRow(at: indexPath)
        tableViewCell?.accessoryType = .none
    }

    @objc func didTapNext(sender:UIBarButtonItem) {
        guard let selectedRows = self.tableView.indexPathsForSelectedRows else {
            return
        }

        let types:[GestureRecognizerType] = selectedRows.map {
            GestureRecognizerType(rawValue: $0.row)!
        }
        let awesomeViewController = AwesomeViewController(types: types)
        self.navigationController?.pushViewController(awesomeViewController, animated: true)
    }
}
