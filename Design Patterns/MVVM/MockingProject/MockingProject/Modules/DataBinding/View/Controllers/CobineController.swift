//
//  APIRouter.swift
//  MockingProject
//
//  Created by Paa Quesi Afful on 01/04/2020.
//  Copyright © 2020 MockingProject. All rights reserved.
//

import UIKit
import ESPullToRefresh
import Combine

class CombineController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var emptyView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var viewModel: CombineViewModel = {
        let viewModel = CombineViewModel()
        return viewModel
    }()

    private var cancellables: Set<AnyCancellable> = []

	override func viewDidLoad() {
		super.viewDidLoad()
		showLoader()
		setupTableView()
        bindViewModel()
	}

    private func bindViewModel() {
        viewModel.$employees.sink { [weak self] _ in
            self?.showTableView()
        }.store(in: &cancellables)
    }

	func setupTableView() {
		self.tableView.register(UINib(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: "EmployeeCell")
		self.tableView.dataSource = self
		self.tableView.delegate = self
		self.tableView.tableFooterView = UIView()
		self.tableView.es.addPullToRefresh {
            self.viewModel.fetchEmployees()
		}
		self.tableView.es.startPullToRefresh()
	}

	func showLoader() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = true
		self.activityIndicator.isHidden = false
		self.activityIndicator.startAnimating()
	}

	func showEmptyView() {
		self.tableView.isHidden = true
		self.emptyView.isHidden = false
		self.activityIndicator.isHidden = true
	}

	func showTableView() {
		DispatchQueue.main.async {
			self.tableView.es.stopPullToRefresh()
			self.tableView.reloadData()
			self.tableView.isHidden = false
			self.emptyView.isHidden = true
			self.activityIndicator.isHidden = true
		}
	}

	func moveToDetails(item: Employee) {
		DispatchQueue.main.async {
			let detailController = DetailController().initializeFromStoryboard()
			detailController.item = item
			self.navigationController?.pushViewController(detailController, animated: true)
		}
	}

}

extension CombineController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let item = self.viewModel.employees[indexPath.row]
		self.moveToDetails(item: item)
	}
}

extension CombineController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.viewModel.employees.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath) as! EmployeeCell
        cell.item = self.viewModel.employees[indexPath.row]
		return cell
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
	}
}
