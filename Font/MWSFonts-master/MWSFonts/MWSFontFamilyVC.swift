//
//  MWSFontFamilyVC.swift
//  MWSFonts
//
//  Created by Eric Turner on 2/5/15.
//  Copyright (c) 2015 MagicWave Software. All rights reserved.
//

import Foundation
import UIKit


class MWSFontFamilyVC: UITableViewController { //, UISplitViewControllerDelegate {

    
    private let cellId = "FontCell_ID"
//    private var collapseSelectionTVC = true
    private var fontNames = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        println("awakeFromNib called")
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad called")
        
//        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", 
//            style: UIBarButtonItemStyle.Plain, 
//            target: nil, 
//            action: nil)
        
        self.configureView()
    }


    var fontFamily: String? {
        didSet {
            if let fontFamily = fontFamily {
                loadFonts()
            }
            self.configureView()
        }
    }
    
    func loadFonts() {
        println("fontFamily:\(fontFamily)")
        fontNames += UIFont.fontNamesForFamilyName(fontFamily!) as [String]
        fontNames.sort(<)
        println("fontNames.count:\(fontNames.count)")
    }
    
    func configureView() {
        if let fontFamily = self.fontFamily {
            self.title = "\(fontFamily) Family"
        }
    }
    
    
    // MARK: - Segues
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let detailNavCon = segue.destinationViewController as? UINavigationController {
//            if let fontDetailVC = detailNavCon.topViewController as? MWSFontDetailVC {
//                if let selectedRowIndexPath = tableView.indexPathForSelectedRow() {
//                    let fontName = fontNames[selectedRowIndexPath.row]
//                    fontDetailVC.detailItem = fontName
//                }
//                
//            }
//        }
//    }


    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as UITableViewCell
        
        let fName = fontNames[indexPath.row] as String
        cell.textLabel!.text = fName
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    
    // MARK: Table View Delegate
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        collapseSelectionTVC = false
//    }
    
    
//    // MARK: - UISplitViewControllerDelegate
//    
//    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
//        return collapseSelectionTVC
//    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}