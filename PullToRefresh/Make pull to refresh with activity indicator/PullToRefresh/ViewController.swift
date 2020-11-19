//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Exlinct on 10/4/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var pullToRefreshView: PullToRefreshView = {
        
        guard let pullToRefreshView = PullToRefreshView.fromNib() as? PullToRefreshView else { return PullToRefreshView()}
        
        pullToRefreshView.delegate = self
        pullToRefreshView.backgroundColor = UIColor.red
        pullToRefreshView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableView.insertSubview(pullToRefreshView, at: 0)
        
        let viewsDictionary = [
            "pullToRefreshView": pullToRefreshView,
            "view": self.tableView ?? UITableView(),
            ]
        
        let constraintsV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-85)-[pullToRefreshView(80)]",
                                                                          options: [],
                                                                          metrics: nil,
                                                                          views: viewsDictionary)
        
        let constraintsH = NSLayoutConstraint.constraints(withVisualFormat: "H:|[pullToRefreshView(==view)]|",
                                                                          options: [],
                                                                          metrics: nil,
                                                                          views: viewsDictionary)
        
        NSLayoutConstraint.activate(constraintsV)
        NSLayoutConstraint.activate(constraintsH)
        
        return pullToRefreshView
    }()
    
    var items = [String]()
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pullToRefreshView.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        pullToRefreshView.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pullToRefreshView.scrollViewDidEndScrollingAnimation(scrollView)
    }
}

extension ViewController: PullToRefreshViewDelegate {
    func pulllToRefreshViewDidRefresh(_ pulllToRefreshView: PullToRefreshView) {
        
        //            activityIndicator.alpha = 0
        
        let finish: () -> Void = { [weak self] in
            delay(0.3) { // 人为延迟，增加等待感
                pulllToRefreshView.endRefreshingAndDoFurtherAction() {}
                
                if let strongSelf = self {
                    strongSelf.items.append("1")
                    strongSelf.tableView.reloadData()
                }
            }
        }
        
        pullToRefreshView.refreshTimeoutAction = finish
        
        //            updateFeeds(finish: finish)
    }
    
    func scrollView() -> UIScrollView {
        return tableView
    }
}



