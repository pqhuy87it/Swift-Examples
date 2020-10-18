//
//  MediaResourceProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol MediaResource : RemoteResource {
    var mediaHost: String { get }
    var mediaPath: String { get }
}

extension MediaResource {
    // Default host value for media resources
    var mediaHost: String { return "media.pearmusic.com" }
    
    // Generate the fully qualified URL
    var mediaURL: String { return String(format: "http://%@%@", self.mediaHost, self.mediaPath) }
    
    // Main loading method
    func loadMedia(completion: (()->())?) {
        self.load(url: self.mediaURL) { (success) -> () in
            // Execute completion block on the main queue
            if let completion = completion {
                DispatchQueue.main.async(execute: completion)
            }
        }
    }
    
    var imageValue: UIImage? {
        if let d = self.dataForURL(url: self.mediaURL) {
            return UIImage(data: d as Data)
        }
        return nil
    }
}

extension MediaResource where Self: Unique {
    var mediaPath: String { return String(format: "/images/%@", self.id) }
}
