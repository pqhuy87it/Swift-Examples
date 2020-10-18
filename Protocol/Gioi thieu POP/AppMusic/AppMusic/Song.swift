//
//  Song.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class Song {
    var id: Int!
    var trackName: String?
    var trackPrice: Double?
    var streamURL: String?
    var duration: NSNumber?
    var imageURL: String?
    
    init(id: Int, trackName: String, trackPrice: Double) {
        self.id = id
        self.trackName = trackName
        self.trackPrice = trackPrice
    }
}
