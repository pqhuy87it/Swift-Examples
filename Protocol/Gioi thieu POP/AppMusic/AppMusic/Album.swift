//
//  Album.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class Album: JSONResource, MediaResource {
    var id: Int!
    var albumName: String?
    var albumUrlImage: String?
    var copyRight: String?
    var trackCount: Int?
    var albumPrice: Double?
    var songs: [Song]?
    
    var isLoadingMedia = false
    
    init(id: Int, albumName: String, albumUrlImage: String, copyRight: String, trackCount: Int, albumPrice: Double) {
        self.id = id
        self.albumName = albumName
        self.albumUrlImage = albumUrlImage
        self.copyRight = copyRight
        self.trackCount = trackCount
        self.albumPrice = albumPrice
    }
}
