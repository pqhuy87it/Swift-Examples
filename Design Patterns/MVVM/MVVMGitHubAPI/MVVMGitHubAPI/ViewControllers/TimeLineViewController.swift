//
//  TimeLineViewController.swift
//  MVVMGitHubAPI
//
//  Created by 大西玲音 on 2021/04/04.
//

//UserListViewModelから通知を受け取り、tableViewを更新する
//UserListViewModelの保持するUserCellViewModelから通知を受け取り、画像を更新するまたcellに必要なUserCελlViewModelのアウトプットをCellにセットする
//Cellを選択したらそのユーザーのGitHubページへ画面遷移する

import UIKit
import SafariServices

final class TimeLineViewController: UIViewController {
    
    private var viewModel: UserListViewModel!
    private var tableView: UITableView!
    private var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeLineCell.self, forCellReuseIdentifier: TimeLineCell.id)
        self.view.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueDidChange(sender: )), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewModel = UserListViewModel()
        viewModel.stateDidUpdate = { [weak self] state in
            switch state {
            case .loading:
                self?.tableView.isUserInteractionEnabled = false
            case .finish:
                self?.tableView.isUserInteractionEnabled = true
                self?.tableView.reloadData()
            case .error(let error):
                self?.tableView.isUserInteractionEnabled = true
                self?.refreshControl.endRefreshing()
                let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
        viewModel.getUsers()

    }

    @objc private func refreshControlValueDidChange(sender: UIRefreshControl) {
        viewModel.getUsers()
    }

}

extension TimeLineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cellViewModel = viewModel.cellViewModels[indexPath.row]
        let webUrl = cellViewModel.webUrl
        let webViewController = SFSafariViewController(url: webUrl)
        present(webViewController, animated: true)
    }
    
}

extension TimeLineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.usersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let timeLineCell = tableView.dequeueReusableCell(withIdentifier: TimeLineCell.id) as? TimeLineCell {
            let cellViewModel = viewModel.cellViewModels[indexPath.row]
            timeLineCell.setNickName(nickName: cellViewModel.nickName)
            cellViewModel.downloadImage { progress in
                switch progress {
                case .loading(let image):
                    timeLineCell.setIcon(icon: image)
                case .finish(let image):
                    timeLineCell.setIcon(icon: image)
                case .error:
                    break
                }
            }
            return timeLineCell
        }
        fatalError()
    }
    
}
