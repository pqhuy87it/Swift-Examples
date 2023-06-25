//
//  UserListViewModel.swift
//  MVVMGitHubAPI
//
//  Created by 大西玲音 on 2021/04/04.
//

import Foundation
import UIKit

enum ViewModelState {
    case loading
    case finish
    case error(Error)
}

final class UserListViewModel {
    
    var stateDidUpdate: ((ViewModelState) -> Void)?
    private var users = [User]()
    var cellViewModels = [UserCellViewModel]()
    let api = API()
    
    func getUsers() {
        stateDidUpdate?(.loading)
        users.removeAll()
        api.getUsers { result in
            switch result {
            case .success(let users):
                self.users.append(contentsOf: users)
                users.forEach { user in
                    let cellViewModel = UserCellViewModel(user: user) 
                    self.cellViewModels.append(cellViewModel)
                    self.stateDidUpdate?(.finish)
                }
            case .failure(let error):
                self.stateDidUpdate?(.error(error))
            }
        }
    }
    
    func usersCount() -> Int {
        return users.count
    }
    
}
