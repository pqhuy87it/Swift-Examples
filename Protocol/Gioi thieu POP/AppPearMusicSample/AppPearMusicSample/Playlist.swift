//
//  Playlist.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class Playlist: NSObject, JSONResource, MediaResource, Unique {
    // MARK: - Metadata
    var title: String?
    var createdBy: String?
    var songs: [Song]?
    
    // MARK: - Unique
    var id: String!
}
