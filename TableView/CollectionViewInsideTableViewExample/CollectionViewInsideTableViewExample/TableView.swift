//
//  ViewController.swift
//  CollectionViewInsideTableViewExample
//
//  Created by John Codeos on 12/20/19.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

public struct Section {
    var name: String
    var collapsed: Bool
    
    public init(name: String, collapsed: Bool = false) {
        self.name = name
        self.collapsed = collapsed
    }
}


class TableView: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var colorsArray = Colors()
    var tappedCell: CollectionViewCellModel!
    var sections:[Section] = [Section(name: "Section 1"), Section(name: "Section2"), Section(name: "Section3"), Section(name: "Section5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.colorFromHex("#9E1C40")
        tableView.separatorStyle = .none
        
        // Register the xib for tableview cell
        let cellNib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "tableviewcellid")
        self.tableView.registerHeaderFooter(CollapsibleTableViewHeader.self)
    }
}

extension TableView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].collapsed ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // Category Title
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueHeaderFooter(CollapsibleTableViewHeader.self) else {
            return nil
        }
        
        headerView.contentView.backgroundColor = UIColor.gray
        headerView.section = section
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewcellid", for: indexPath) as? TableViewCell {
            // Show SubCategory Title
            let subCategoryTitle = colorsArray.objectsArray[indexPath.section].subcategory
            cell.subCategoryLabel.text = subCategoryTitle[indexPath.row]

            // Pass the data to colletionview inside the tableviewcell
            let rowArray = colorsArray.objectsArray[indexPath.section].colors[indexPath.row]
            cell.updateCellWith(row: rowArray)

            // Set cell's delegate
            cell.cellDelegate = self
            
            cell.selectionStyle = .none
            return cell
       }
        return UITableViewCell()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsviewcontrollerseg" {
            let DestViewController = segue.destination as! DetailsViewController
            DestViewController.backgroundColor = tappedCell.color
            DestViewController.backgroundColorName = tappedCell.name
        }
    }
}

extension TableView: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: TableViewCell) {
        if let colorsRow = didTappedInTableViewCell.rowWithColors {
            self.tappedCell = colorsRow[index]
            performSegue(withIdentifier: "detailsviewcontrollerseg", sender: self)
            // You can also do changes to the cell you tapped using the 'collectionviewcell'
        }
    }
}


//
// MARK: - Section Header Delegate
//
extension TableView: CollapsibleTableViewHeaderDelegate {
    
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        // Toggle collapse
        sections[section].collapsed = collapsed
        
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
    
}
