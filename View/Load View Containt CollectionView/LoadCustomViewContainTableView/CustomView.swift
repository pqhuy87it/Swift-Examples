//
//  CustomView.swift
//  LoadCustomViewContainTableView
//
//  Created by Exlinct on 8/21/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

final class CustomView: UIView {

    static let height: CGFloat = 300.0
    weak var bottomConstraint: NSLayoutConstraint?
     var handleAction: (() -> Void)?
    
    @IBOutlet weak var dataTableView: UITableView! {
        didSet {
            dataTableView.dataSource = self
            dataTableView.delegate = self
            dataTableView.rowHeight = 40.0
            
            dataTableView.registerNibOf(DataCell.self)
        }
    }
    
    func show() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.bottomConstraint?.constant = 0
            self?.superview?.layoutIfNeeded()
            }, completion: { _ in })
    }
    
    func hide() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: { [weak self] in
            self?.bottomConstraint?.constant = CustomView.height
            self?.superview?.layoutIfNeeded()
            }, completion: { _ in })
    }
}

extension CustomView: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell: DataCell = tableView.dequeueReusableCell()
        dataCell.configCellWithData(["1","2","3"])
        return dataCell
    }
}

extension CustomView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.handleAction?()
    }
}

