//
//  MWSMasterFontFamiliesVC.swift
//  MWSFonts
//
//  Created by Eric Turner on 2/5/15.
//  Copyright (c) 2015 MagicWave Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

struct MWSFontFamily {
    let familyName: String
    let fontNames:  [String]
}

/// This is a somewhat contrived extension that returns the MWSFontDetailVC
/// hasFonts() return value. It's used in the UISplitViewControllerDelegate
/// splitViewController:collapseSecondary:onto: callback to determine if
/// the master vc should be displayed or not.
///
/// .phone: 
/// If a font selection has not been made and loaded into the detail vc,
/// then the master should display. On iPhone this callback is called
/// at launch before the views appear.
///
/// .pad:
/// The splitViewController.preferredDisplayMode is set to .primaryOverlay
/// in viewDidLoad, and the callback is not called, which results in the
/// master displaying over the detail on iPad at launch.
extension UISplitViewController {
    func detailVcHasFontsLoaded() -> Bool {
        if let detailNavCon = self.children.first as? UINavigationController,
            let detailVC = detailNavCon.topViewController as? MWSFontDetailVC {
            return detailVC.hasFonts()
        }
        return false 
    }
}

class MWSMasterFontFamiliesVC: UITableViewController, UISplitViewControllerDelegate {

    fileprivate let cellId = "FontFamilyCell_ID"
    fileprivate var fontFamilyNames = [MWSFontFamily]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load font data
        let familyNames = UIFont.familyNames.sorted(by: <)
        for name in familyNames {
            let data = MWSFontFamily(familyName: name, fontNames: UIFont.fontNames(forFamilyName: name) )
            fontFamilyNames.append(data)
        }        
        //LOG
//        print("fontFamilyNames.count:\(fontFamilyNames.count)")
    
        splitViewController?.delegate = self
        /// At launch, we want the master displayed on any device.
        self.splitViewController?.preferredDisplayMode = .primaryOverlay

        self.clearsSelectionOnViewWillAppear = false
        if UIDevice.current.userInterfaceIdiom == .pad {            
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        
        self.title = "iOS Font Families (\(fontFamilyNames.count))"
        navigationItem.backBarButtonItem = nil
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", 
                                                           style: UIBarButtonItem.Style.plain, 
            target: nil, 
            action: nil)        
    }
    
    /// Note that in viewDidLoad clearsSelectionOnViewWillAppear is set
    /// to false. This is so that when returning from the detail vc to
    /// the master vc, the selected family name row will still be
    /// highlighted. Here, we deselect with animation.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let ip = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: ip, animated: true)
        }
    }    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailNavCon = segue.destination as? UINavigationController,
            let familyDetailVC = detailNavCon.topViewController as? MWSFontDetailVC,
            let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                let fontFamilyData = fontFamilyNames[selectedRowIndexPath.row] as MWSFontFamily
                familyDetailVC.fontFamily = fontFamilyData
            
            /// On iPad, this dismisses the master vc when a table row is
            /// selected.
            if view.traitCollection.userInterfaceIdiom == .pad && splitViewController?.displayMode == .primaryOverlay {
                UIView.animate(withDuration: 0.3, animations: { 
                    self.splitViewController?.preferredDisplayMode = .primaryHidden
                    }, completion: { (finished) in
                        self.splitViewController?.preferredDisplayMode = .automatic
                })
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontFamilyNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) 

        let data = fontFamilyNames[indexPath.row]
        let fName = data.familyName
        cell.textLabel!.text = fName
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
       
        var shouldCollapse = true
        if view.traitCollection.userInterfaceIdiom != .pad {
            shouldCollapse = !splitViewController.detailVcHasFontsLoaded()
        }
       
        return shouldCollapse
    }

    
    //MARK: UIViewController Boilerplate
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

