
import UIKit

/// Cell Reuse Identifier
extension Row {
    var reuseIdentifier:String {
        switch self {
        case .Contact, .Settings:
            return "redCell"
        default:
            return "blueCell"
        }
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = TableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.schema[section].rows.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return viewModel.schema.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.viewModel.schema[indexPath.section].rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath) as UITableViewCell
        cell.imageView?.image = row.icon
        cell.textLabel?.text = row.displayName
        cell.accessoryType = row.URL == nil ? .none : .disclosureIndicator
        cell.selectionStyle = row.URL == nil ? .none : .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.schema[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let row = self.viewModel.schema[indexPath.section].rows[indexPath.row]
        if let stringURL = row.URL {
            if let url = URL(string: stringURL) {
                UIApplication.shared.openURL(url)
            }
        }
    }


}

