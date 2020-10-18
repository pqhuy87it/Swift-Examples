//
//  ViewController.swift
//  StickyHeader
//
//  Created by ismail el habbash on 17/05/2016.
//  Copyright © 2016 ismail el habbash. All rights reserved.
//

import UIKit



class ViewController: UITableViewController , StickyHeaderProtocol {
    let items = [
        NewsItem(category: .World, summary: "Climate change protests, divestments meet fossil fuels realities"),
        NewsItem(category: .Europe, summary: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime'"),
        NewsItem(category: .MiddleEast, summary: "Syria is under attack"),
        NewsItem(category: .Africa, summary: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
        NewsItem(category: .AsiaPacific, summary: "Despite UN ruling, Japan seeks backing for whale hunting"),
        NewsItem(category: .Americas, summary: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
        NewsItem(category: .World, summary: "South Africa in $40 billion deal for Russian nuclear reactors"),
        NewsItem(category: .Europe, summary: "'One million babies' created by EU student exchanges"),
        ]

    var delegate: StickyHeaderProtocol?
    lazy var headerView = UIView()
    var stickyTableView: UITableView {
        return self.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension

        delegate = self
        headerView = tableView.tableHeaderView!

        delegate?.stickyHeaderDelegateDidGetHeader(headerView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension ViewController {

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView(headerView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsItemCellTableViewCell
        cell.newsItem = item
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}
