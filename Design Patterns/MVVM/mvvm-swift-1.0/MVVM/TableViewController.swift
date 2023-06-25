//
//  TableViewController.swift
//  MVVM
//
//  Created by Jure Zove on 01/05/16.
//  Copyright © 2016 Jure Zove. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let cars: [CarViewModel] = (UIApplication.shared.delegate as! AppDelegate).cars
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)
        let carViewModel = cars[indexPath.row]
        
        cell.textLabel?.text = carViewModel.titleText
        cell.detailTextLabel?.text = carViewModel.horsepowerText
        loadImage(cell, photoURL: carViewModel.photoURL)
        
        return cell
    }
    
    func loadImage(_ cell: UITableViewCell, photoURL: URL?) {
        DispatchQueue.global().async {
            guard let imageURL = photoURL else {
                return
            }
            
            do {
                let imageData = try Data(contentsOf: imageURL)
                
                DispatchQueue.main.async(execute: { () -> Void in
                    cell.imageView?.image = UIImage(data: imageData)
                    cell.setNeedsLayout()
                })
            } catch {
                
            }
        }
    }
    
}
