//
//  StackTableViewController.swift
//  StaskView
//
//  Created by Julio Collado on 7/29/19.
//  Copyright © 2019 Julio Collado. All rights reserved.
//

import UIKit

class StackTableViewController: UIViewController {

    @IBOutlet weak var tableViewTest: UITableView!
    private let colorName = ["RED VIEW","BLUE VIEW","YELLOW VIEW","GREEN VIEW","GRAY VIEW","WHITE VIEW","BROWN VIEW"]
    private let colors = [UIColor.red,UIColor.blue,UIColor.yellow,UIColor.green,UIColor.gray,UIColor.white,UIColor.brown]
    private var viewsPerCell: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewTest.delegate = self
        tableViewTest.dataSource = self
        tableViewTest.allowsSelection = false
        setViewsPerCell()
    }
    
    ///Set the number of views to add in every cell
    private func setViewsPerCell() {
        colorName.forEach { (_) in
            let randomNumber = Int.random(in: 0 ..< 7)
            viewsPerCell.append(randomNumber)
        }
    }

}

extension StackTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colorName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewTest.dequeueReusableCell(withIdentifier: "TableViewCellPrototype") as! TableViewCellPrototype
        cell.label.text = "CELL NUMBER: \(indexPath.row)"
        
        //cleaning stackView to reuse it
        cell.stackColors.subviews.forEach { (view) in
            if !(view is UILabel) {
                view.removeFromSuperview()
            }
        }
        
        let viewsToDrow = viewsPerCell[indexPath.row]
        
        //Adding custom views to the stackView
        for colorIndex in 0 ... viewsToDrow {
            let nib = CustomView()
            nib.label.text = colorName[colorIndex]
            nib.backgroundColor = colors[colorIndex]
            cell.stackColors.addArrangedSubview(nib)
        }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
  
}
