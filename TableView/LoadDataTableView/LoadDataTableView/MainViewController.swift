//
//  MainViewController.swift
//  LoadDataTableView
//
//  Created by Pham Quang Huy on 7/15/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var array = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        array = ["TableView No Data",
                 "Table Load More No Data"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let noDataViewController = mainStoryboard.instantiateViewController(withIdentifier: "NoDataViewController") as! NoDataViewController
            noDataViewController.isNodata = true
            self.navigationController?.pushViewController(noDataViewController, animated: true)
        }
    }
}
