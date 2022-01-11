//
//  ViewController.swift
//  LoadDataTableView
//
//  Created by Pham Quang Huy on 7/15/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class NoDataViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var array = [String]()
    var refreshControl = UIRefreshControl()
    var noDataView: NoDataView!
    var isNodata = false
    var isLoadingData = false
    var isNoMoreData = false
    var loadingMoreDataTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activityIndicator.startAnimating()
        setupViews()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        if isLoadingData {
            print("loading data")
            return
        }
        
        delay(time: 3.0) {[weak self] in
            guard let weakSelf = self else {
                return
            }
            
            if weakSelf.activityIndicator.isAnimating {
                weakSelf.activityIndicator.stopAnimating()
            }

            guard !weakSelf.isNodata else {
                self?.noDataView.isHidden = false
                self?.tableView.reloadData()
                return
            }
            
            for i in 0..<20 {
                weakSelf.array.append("\(i)")
            }
            
            if weakSelf.array.count > 0 {
                weakSelf.noDataView.isHidden = true
            }
            
            weakSelf.tableView.reloadData()
            
            if weakSelf.refreshControl.isRefreshing {
                weakSelf.refreshControl.endRefreshing()
            }
        }
    }
    
    func loadMoreData() {
        if self.isLoadingData {
            print("loading data break.")
            return
        }
        
        if isNoMoreData {
            print("have no more data")
            return
        }
        
        isLoadingData = true
        
        delay(time: 3.0) {[weak self] in
            guard let weakSelf = self else {
                return
            }
            
            guard weakSelf.loadingMoreDataTime != 2 else {
                weakSelf.isNoMoreData = true
                weakSelf.tableView.reloadRows(at: [IndexPath(row: weakSelf.array.count, section: 0)], with: .none)
                weakSelf.isLoadingData = false
                return
            }
            
            for i in 0..<20 {
                weakSelf.array.append("\(i)")
                weakSelf.tableView.beginUpdates()
                weakSelf.tableView.insertRows(at: [IndexPath(row: weakSelf.array.count - 1, section: 0)], with: .automatic)
                weakSelf.tableView.endUpdates()
            }
            
            weakSelf.isLoadingData = false
            weakSelf.loadingMoreDataTime += 1
        }
    }
    
    @objc func refreshData() {
        refreshControl.beginRefreshing()
        isNodata = false
        loadData()
    }
    
    func setupViews() {
        self.activityIndicator.hidesWhenStopped = true
        
        // register cell
        tableView.register(UINib(nibName: "LoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        
        // setup refresh control
        refreshControl.addTarget(self, action: #selector(NoDataViewController.refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        // setup nodata view
        let noDataView = NoDataView(frame: CGRect.zero)
        noDataView.titleLabel.text = "No Data."
        self.view.insertSubview(noDataView, aboveSubview: tableView)
        noDataView.translatesAutoresizingMaskIntoConstraints = false
        noDataView.isHidden = true
        self.noDataView = noDataView
        
        let top = NSLayoutConstraint(item: noDataView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view.safeAreaLayoutGuide,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 0.0)
        let bottom = NSLayoutConstraint(item: noDataView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view.safeAreaLayoutGuide,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 0.0)
        let leading = NSLayoutConstraint(item: noDataView,
                                         attribute: .leading,
                                         relatedBy: .equal,
                                         toItem: self.view,
                                         attribute: .leading,
                                         multiplier: 1.0,
                                         constant: 0.0)
        let trailing = NSLayoutConstraint(item: noDataView,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: self.view,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: 0.0)
        
        NSLayoutConstraint.activate([top, bottom, trailing, leading])
        
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    func delay(time: TimeInterval, completionHandler: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) { 
            completionHandler()
        }
    }
}

extension NoDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (array.count > 0 ? (array.count + 1) : array.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lastIndex = array.count
        
        if indexPath.row == lastIndex {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath) as! LoadMoreCell
            if isNoMoreData {
                if cell.activityIndicator.isAnimating {
                    cell.activityIndicator.stopAnimating()
                }
                
                cell.titleLabel.text = "No More Data."
            } else {
                cell.activityIndicator.startAnimating()
                cell.titleLabel.text = ""
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}

extension NoDataViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height) {
            print("load more data.")
            loadMoreData()
        }
    }
}

