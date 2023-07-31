//
//  AccordionTableViewController.swift
//  Example: AccordionTableViewController + Only one parent expanded at a time
//
//  Created by Victor Sigler Lopez on 7/5/18.
//  Updated by Kyle Wood on 15/10/19.
//  Copyright © 2018 Victor Sigler. All rights reserved.
//

import UIKit
import AccordionSwift

class AccordionTableViewController: UITableViewController {
    
    // MARK: - Typealias
    
    typealias ParentCellModel = Parent<GroupCellModel, CountryCellModel>
    typealias ParentCellConfig = CellViewConfig<ParentCellModel, UITableViewCell>
    typealias ChildCellConfig = CellViewConfig<CountryCellModel, CountryTableViewCell>
    
    // MARK: - Properties
    
    /// The Data Source Provider with the type of DataSource and the different models for the Parent and Child cell.
    var dataSourceProvider: DataSourceProvider<DataSource<ParentCellModel>, ParentCellConfig, ChildCellConfig>?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDataSource()
        navigationItem.title = "World Cup 2018"
    }
}

extension AccordionTableViewController {
    
    // MARK: - Methods
    
    /// Configure the data source
    private func configDataSource() {
        
        let groupA = Parent(item: GroupCellModel(name: "Group A"),
                            children: [CountryCellModel(name: "Uruguay"),
                                       CountryCellModel(name: "Russia"),
                                       CountryCellModel(name: "Saudi Arabia"),
                                       CountryCellModel(name: "Egypt")]
        )
        
        let groupB = Parent(state: .expanded, item: GroupCellModel(name: "Group B"),
                            children: [CountryCellModel(name: "Spain"),
                                       CountryCellModel(name: "Portugal"),
                                       CountryCellModel(name: "Iran"),
                                       CountryCellModel(name: "Morocco")]
        )
        
        let groupC = Parent(item: GroupCellModel(name: "Group C"),
                            children: [CountryCellModel(name: "France"),
                                       CountryCellModel(name: "Denmark"),
                                       CountryCellModel(name: "Peru"),
                                       CountryCellModel(name: "Australia")]
        )
        
        let groupD = Parent(item: GroupCellModel(name: "Group D"),
                            children: [CountryCellModel(name: "Croatia"),
                                       CountryCellModel(name: "Argentina"),
                                       CountryCellModel(name: "Nigeria"),
                                       CountryCellModel(name: "Iceland")]
        )
        
        let groupE = Parent(item: GroupCellModel(name: "Group E"),
                            children: [CountryCellModel(name: "Brazil"),
                                       CountryCellModel(name: "Switzerland"),
                                       CountryCellModel(name: "Serbia"),
                                       CountryCellModel(name: "Costa Rica")]
        )
        
        let groupF = Parent(item: GroupCellModel(name: "Group F"),
                            children: [CountryCellModel(name: "Sweden"),
                                       CountryCellModel(name: "Mexico"),
                                       CountryCellModel(name: "South Korea"),
                                       CountryCellModel(name: "Germany")]
        )
        
        let groupG = Parent(item: GroupCellModel(name: "Group G"),
                            children: [CountryCellModel(name: "Belgium"),
                                       CountryCellModel(name: "England"),
                                       CountryCellModel(name: "Tunisia"),
                                       CountryCellModel(name: "Panama")]
        )
        
        let groupH = Parent(item: GroupCellModel(name: "Group H"),
                            children: [CountryCellModel(name: "Colombia"),
                                       CountryCellModel(name: "Japan"),
                                       CountryCellModel(name: "Senegal"),
                                       CountryCellModel(name: "Poland")]
        )
        
        let sections = [groupA, groupB, groupC, groupD, groupE, groupF, groupG, groupH].map { parents in
            Section(items: parents)
        }
        
        let dataSource = DataSource(sections)
        
        let parentCellConfig = CellViewConfig<Parent<GroupCellModel, CountryCellModel>, UITableViewCell>(reuseIdentifier: "GroupCell") {
            (cell, model, tableView, indexPath) -> UITableViewCell in
            cell.textLabel?.text = model?.item.name
            return cell
        }
        
        let childCellConfig = CellViewConfig<CountryCellModel, CountryTableViewCell>(reuseIdentifier: "CountryCell") {
            (cell, item, tableView, indexPath) -> CountryTableViewCell in
            cell.contryLabel.text = item?.name
            cell.countryImageView.image = UIImage(named: "\(item!.name.lowercased())")
            return cell
        }
        
        let didSelectParentCell = { (tableView: UITableView, indexPath: IndexPath, item: ParentCellModel?) -> Void in
            print("Parent cell \(item!.item.name) tapped")
        }
        
        let didSelectChildCell = { (tableView: UITableView, indexPath: IndexPath, item: CountryCellModel?) -> Void in
            print("Child cell \(item!.name) tapped")
        }
        
        let scrollViewDidScroll = { (scrollView: UIScrollView) -> Void in
            print(scrollView.contentOffset)
            
        }
        
        dataSourceProvider = DataSourceProvider(
                dataSource: dataSource,
                parentCellConfig: parentCellConfig,
                childCellConfig: childCellConfig,
                didSelectParentAtIndexPath: didSelectParentCell,
                didSelectChildAtIndexPath: didSelectChildCell,
                scrollViewDidScroll: scrollViewDidScroll,
                // Configure DataSourceProvider to have only one parent expanded at a time
                numberOfExpandedParentCells: .single
        )
        
        tableView.dataSource = dataSourceProvider?.tableViewDataSource
        tableView.delegate = dataSourceProvider?.tableViewDelegate
        tableView.tableFooterView = UIView()
    }
}
