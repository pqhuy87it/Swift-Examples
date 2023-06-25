//
//  ProfileLocalRequest.swift
//  MVVM-Clean
//
//  Created by Alessandro Marcon on 17/10/2020.
//  Copyright © 2020 Alessandro Marcon. All rights reserved.
//

import Foundation

class ProfileLocalData: ProfileLocalProtocolData {
    
    func getLocalUserData() -> UserModel? {
        LOGD("Getting local user data")
        let currentUser = UserModel()
        
        if let currentUsername = UserDefaults.standard.string(forKey: "current_user_username") {
            currentUser.username = currentUsername
        }
        
        return currentUser
    }
    
    func saveLocalUserData(currentUser: UserModel) {
        LOGD("Saving local user data")
        UserDefaults.standard.set(currentUser, forKey: "current_user_username")
    }
    
    func deleteLocalUserData() {
        LOGD("Deleting local user data")
        UserDefaults.standard.removeObject(forKey: "current_user_username")
    }
}
