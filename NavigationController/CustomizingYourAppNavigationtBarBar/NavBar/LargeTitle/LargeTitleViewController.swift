/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Demonstrates applying a large title to the UINavigationBar.
*/

import UIKit

class LargeTitleViewController: UITableViewController {

	/// Our data source is an array of city names, populated from Cities.json.
	let dataSource = CitiesDataSource()
	
    /// - Tag: LargeTitleExample
    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.dataSource = dataSource
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "pushSeque" {
			// This segue is pushing a detailed view controller.
			if let indexPath = self.tableView.indexPathForSelectedRow {
				segue.destination.title = dataSource.city(index: indexPath.row)
			}
            
            // We choose not to have a large title for the destination view controller.
            segue.destination.navigationItem.largeTitleDisplayMode = .never
		} else {
			// This segue is popping us back up the navigation stack.
		}
	}

}
