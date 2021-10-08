//
//  ViewController.swift
//  CenteredCollectionView
//
//  Created by HuyPQ22 on 2021/10/08.
//

import UIKit

enum ExamplePage: String {
    case programmatic = "Programmatic Example"
    case storyboard = "Storyboard Example"

    static var allCases: [ExamplePage] {
        return [
            .programmatic,
            .storyboard
        ]
    }

    static func page(from index: Int) -> ExamplePage {
        return allCases[index]
    }
}

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "CenteredCollectionView Examples"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ExamplePage.allCases.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell")!
        cell.textLabel?.text = ExamplePage.allCases[indexPath.row].rawValue
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch ExamplePage.page(from: indexPath.row) {
        case .programmatic:
            let programmaticViewController = ProgrammaticViewController()
            show(programmaticViewController, sender: self)
        case .storyboard:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let storyboardViewController = storyboard.instantiateViewController(withIdentifier: "StoryboardExampleViewController")
            show(storyboardViewController, sender: self)
        }
    }
}

