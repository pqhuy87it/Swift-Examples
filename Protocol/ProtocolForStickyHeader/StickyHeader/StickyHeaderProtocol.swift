//
//  StickyHeaderProtocol.swift
//  StickyHeader
//
//  Created by ismail el habbash on 18/05/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import Foundation
import UIKit

protocol StickyHeaderProtocol {

    var stickyTableHeight:CGFloat { get }
    var stickyTableView:UITableView { get }

    // gets the header and then intialises the header
    func stickyHeaderDelegateDidGetHeader(_ headerView: UIView)
    func setupHeaderView(_ headerView: UIView)

    func updateHeaderView(_ headerView: UIView)
}

extension StickyHeaderProtocol where Self:UITableViewController {

    var stickyTableHeight:CGFloat {
        return self.stickyTableView.bounds.height/2.5
    }

    func stickyHeaderDelegateDidGetHeader(_ headerView:UIView) {
        stickyTableView.tableHeaderView = nil
        setupHeaderView(headerView)
        updateHeaderView(headerView)
    }

    func updateHeaderView(_ headerView:UIView) {
        var headerRect = CGRect(x: 0, y: -stickyTableHeight, width: stickyTableView.bounds.width, height: stickyTableHeight)

        if stickyTableView.contentOffset.y < -stickyTableHeight {
            headerRect.origin.y = stickyTableView.contentOffset.y
            headerRect.size.height = -stickyTableView.contentOffset.y
        }
        headerView.frame = headerRect
    }

    func setupHeaderView(_ headerView:UIView) {
        stickyTableView.addSubview(headerView)
        stickyTableView.contentInset = UIEdgeInsets(top: stickyTableHeight, left: 0, bottom: 0, right: 0)
        stickyTableView.contentOffset = CGPoint(x: 0, y: -stickyTableHeight)
    }
}
