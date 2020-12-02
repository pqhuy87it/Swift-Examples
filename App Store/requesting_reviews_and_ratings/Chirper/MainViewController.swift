/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

private enum State {
  case loading
  case paging([Recording], next: Int)
  case populated([Recording])
  case empty
  case error(Error)
  
  var currentRecordings: [Recording] {
    switch self {
    case .paging(let recordings, _):
      return recordings
    case .populated(let recordings):
      return recordings
    default:
      return []
    }
  }
}

class MainViewController: UIViewController {
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var activityIndicator: UIActivityIndicatorView!
  @IBOutlet private var loadingView: UIView!
  @IBOutlet private var emptyView: UIView!
  @IBOutlet private var errorLabel: UILabel!
  @IBOutlet private var errorView: UIView!
  
  private let searchController = UISearchController(searchResultsController: nil)
  private let networkingService = NetworkingService()

  private var state = State.loading {
    didSet {
      setFooterView()
      tableView.reloadData()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSearchBar()
    loadRecordings()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  // MARK: - Loading recordings
  
  @objc private func loadRecordings() {
    state = .loading
    loadPage(1)
  }
  
  private func loadPage(_ page: Int) {
    let query = searchController.searchBar.text
    networkingService.fetchRecordings(matching: query, page: page) { [weak self] response in
      guard let self = self else {
        return
      }
      
      self.searchController.searchBar.endEditing(true)
      self.update(response: response)
    }
  }
  
  private func update(response: RecordingsResult) {
    if let error = response.error {
      state = .error(error)
      return
    }
    
    guard let newRecordings = response.recordings,
      !newRecordings.isEmpty else {
        state = .empty
        return
    }
    
    var allRecordings = state.currentRecordings
    allRecordings.append(contentsOf: newRecordings)
    
    if response.hasMorePages {
      state = .paging(allRecordings, next: response.nextPage)
    } else {
      state = .populated(allRecordings)
    }
  }
  
  // MARK: - View Configuration
  
  private func setFooterView() {
    switch state {
    case .error(let error):
      errorLabel.text = error.localizedDescription
      tableView.tableFooterView = errorView
    case .loading:
      tableView.tableFooterView = loadingView
    case .paging:
      tableView.tableFooterView = loadingView
    case .empty:
      tableView.tableFooterView = emptyView
    case .populated:
      tableView.tableFooterView = nil
    }
  }
  
  private func prepareSearchBar() {
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.delegate = self
    searchController.searchBar.autocapitalizationType = .none
    searchController.searchBar.autocorrectionType = .no
    
    searchController.searchBar.tintColor = .white
    searchController.searchBar.barTintColor = .white

    let textFieldInSearchBar = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    textFieldInSearchBar.defaultTextAttributes = [
      .foregroundColor: UIColor.white
    ]
    
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

// MARK: -

extension MainViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
                 selectedScopeButtonIndexDidChange selectedScope: Int) {
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    NSObject.cancelPreviousPerformRequests(withTarget: self,
                                           selector: #selector(loadRecordings),
                                           object: nil)
    
    perform(#selector(loadRecordings), with: nil, afterDelay: 0.5)
  }
}

extension MainViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    return state.currentRecordings.count
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: BirdSoundTableViewCell.reuseIdentifier)
      as? BirdSoundTableViewCell else {
        return UITableViewCell()
    }
    
    cell.load(recording: state.currentRecordings[indexPath.row])
    
    if case .paging(_, let nextPage) = state,
      indexPath.row == state.currentRecordings.count - 1 {
      loadPage(nextPage)
    }
    
    return cell
  }
}
