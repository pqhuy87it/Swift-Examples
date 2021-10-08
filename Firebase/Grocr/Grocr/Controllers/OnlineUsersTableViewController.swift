/// Copyright (c) 2021 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import Firebase

class OnlineUsersTableViewController: UITableViewController {
  // MARK: Constants
  let userCell = "UserCell"

  // MARK: Properties
  var currentUsers: [String] = []
  let usersRef = Database.database().reference(withPath: "online")
  var usersRefObservers: [DatabaseHandle] = []

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }

  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    let childAdded = usersRef
      .observe(.childAdded) { [weak self] snap in
        guard
          let email = snap.value as? String,
          let self = self
        else { return }
        self.currentUsers.append(email)
        let row = self.currentUsers.count - 1
        let indexPath = IndexPath(row: row, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .top)
      }
    usersRefObservers.append(childAdded)

    let childRemoved = usersRef
      .observe(.childRemoved) {[weak self] snap in
        guard
          let emailToFind = snap.value as? String,
          let self = self
        else { return }

        for (index, email) in self.currentUsers.enumerated()
        where email == emailToFind {
          let indexPath = IndexPath(row: index, section: 0)
          self.currentUsers.remove(at: index)
          self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
      }
    usersRefObservers.append(childRemoved)
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    usersRefObservers.forEach(usersRef.removeObserver(withHandle:))
    usersRefObservers = []
  }

  // MARK: UITableView Delegate methods
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentUsers.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
    let onlineUserEmail = currentUsers[indexPath.row]
    cell.textLabel?.text = onlineUserEmail
    return cell
  }

  // MARK: Actions
  @IBAction func signOutDidTouch(_ sender: AnyObject) {
    guard let user = Auth.auth().currentUser else { return }

    let onlineRef = Database.database().reference(withPath: "online/\(user.uid)")
    onlineRef.removeValue { error, _ in
      if let error = error {
        print("Removing online failed: \(error)")
        return
      }
      do {
        try Auth.auth().signOut()
        self.navigationController?.popToRootViewController(animated: true)
      } catch let error {
        print("Auth sign out failed: \(error)")
      }
    }
  }
}
