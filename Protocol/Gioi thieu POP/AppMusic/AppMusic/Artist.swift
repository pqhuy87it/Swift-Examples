//
//  Artist.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

class Artist: JSONResource {
    var id: String!
    var name: String?
    var albums: [Album]?
}
