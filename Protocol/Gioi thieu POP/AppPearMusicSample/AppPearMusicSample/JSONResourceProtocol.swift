//
//  JSONResourceProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol JSONResource : RemoteResource {
    var jsonHost: String { get }
    var jsonPath: String { get }
    func processJSON(success: Bool)
}

extension JSONResource {
    // Default host value for REST resources
    var jsonHost: String { return "api.pearmusic.com" }
    
    // Generate the fully qualified URL
    var jsonURL: String { return String(format: "http://%@%@", self.jsonHost, self.jsonPath) }
    
    // Main loading method.
    func loadJSON(completion: (()->())?) {
        self.load(url: self.jsonURL) { (success) -> () in
            // Call adopter to process the result
            self.processJSON(success: success)
            
            // Execute completion block on the main queue
            if let completion = completion {
                DispatchQueue.main.async(execute: completion)
            }
        }
    }
    
    var jsonValue: [String : AnyObject]? {
        do {
            if let d = self.dataForURL(url: self.jsonURL), let result = try JSONSerialization.jsonObject(with: d as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject] {
                return result
            }
        } catch {}
        
        return nil
    }
}

extension JSONResource where Self: Song {
    var jsonPath: String { return String(format: "/songs/%@", self.id) }
    
    func processJSON(success: Bool) {
        if let json = self.jsonValue, success {
            self.title = json["title"] as? String ?? ""
            self.artist = json["artist"] as? String ?? ""
            self.streamURL = json["url"] as? String ?? ""
            self.duration = json["duration"] as? NSNumber ?? 0
        }
    }
}

extension JSONResource where Self: Playlist {
    var jsonPath: String { return String(format: "/playlists/%@", self.id) }
    
    func processJSON(success: Bool) {
        if let json = self.jsonValue, success {
            self.title = json["title"] as? String ?? ""
            self.createdBy = json["createdBy"] as? String ?? ""
            // etc...
        }
    }
}
