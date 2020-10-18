//
//  Song.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class Song : NSObject, JSONResource, Unique {
    // MARK: - Metadata
    var title: String?
    var artist: String?
    var streamURL: String?
    var duration: NSNumber?
    var imageURL: String?
    
    // MARK: - Unique
    var id: String!
}
