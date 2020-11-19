/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Demonstrates using a custom back button image (no back arrow and text).
*/

import UIKit

class CustomBackButtonViewController: UITableViewController {

    /// Our data source is an array of city names, populated from Cities.json.
    var dataSource: CitiesDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = CitiesDataSource()
        tableView.dataSource = dataSource

        // Provide an empty backBarButton to hide the 'Back' text present by default in the back button.
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
    }

}
