//
//  DetailsViewController.swift
//  FloatingPanel
//
//  Created by Azhar Ragab on 06/02/2023.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var animatableView: UIView!
    @IBOutlet weak var tableView: UITableView!

    func getItemList() -> [ItemEntity] {
        return (0...15).map { ItemEntity(name: "Executions: Total number of executions of the statement.Executions:\($0)") }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupTableView()
    }

    init() {
        super.init(nibName: String(describing: Self.self),
            bundle: .init(for: Self.self))
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func setUpView() {
        animatableView.layer.cornerRadius = 10
        animatableView.clipsToBounds = true
    }

    @IBAction func exit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

