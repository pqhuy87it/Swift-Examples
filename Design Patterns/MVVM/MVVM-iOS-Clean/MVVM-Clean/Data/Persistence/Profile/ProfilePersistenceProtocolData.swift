//
//  ProfilePersistenceProtocolData.swift
//  MVVM-Clean
//
//  Created by Alessandro Marcon on 17/10/2020.
//  Copyright © 2020 Alessandro Marcon. All rights reserved.
//

import Foundation

/// Protocol
protocol ProfilePersistenceProtocolData {
    
    /// Get local user data. If there is no data, nil will be returned.
    func getLocalUserData() -> User?
    
    /// Save current user data locally.
    /// - Parameter currentUser: The current UserModel data to save
    func saveLocalUserData(currentUser: User)
    
    /// Delete local user data
    func deleteLocalUserData()
    
    
}
