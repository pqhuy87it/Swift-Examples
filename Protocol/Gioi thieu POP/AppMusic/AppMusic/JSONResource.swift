//
//  JSONResource.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
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
    var jsonHost: String {
        return "itunes.apple.com"
    }
    
    // Generate the fully qualified URL
    var jsonURL: String {
        return String(format: "https://%@%@", self.jsonHost, self.jsonPath)
    }
    
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
        } catch {
        }
        
        return nil
    }
}

extension JSONResource where Self: Artist {
    var jsonPath: String {
        return String(format: "/lookup?id=%@&entity=album", self.id)
    }
    
    func processJSON(success: Bool) {
        if let json = self.jsonValue, success {
            print(json)
            if let results = json["results"] as? [[String: AnyObject]] {
                var _albums = [Album]()
                
                for result in results {
                    if
                        let collectionName = result["collectionName"] as? String,
                        let artworkUrl100 = result["artworkUrl100"] as? String,
                        let collectionPrice = result["collectionPrice"] as? Double,
                        let trackCount = result["trackCount"] as? Int,
                        let copyright = result["copyright"] as? String,
                        let id = result["collectionId"] as? Int {
                        let album = Album(id: id,
                                          albumName: collectionName,
                                          albumUrlImage: artworkUrl100,
                                          copyRight: copyright,
                                          trackCount: trackCount,
                                          albumPrice: collectionPrice)
                        _albums.append(album)
                    }
                }
                
                self.albums = _albums
            }
        }
    }
}

extension JSONResource where Self: Album {
    var jsonPath: String {
        return String(format: "/lookup?id=%@&entity=song", String(self.id))
    }
    
    func processJSON(success: Bool) {
        if let json = self.jsonValue, success {
            if let results = json["results"] as? [[String: AnyObject]] {
                var _songs = [Song]()
                
                for result in results {
                    if
                        let id = result["trackId"] as? Int,
                        let trackName = result["trackName"] as? String,
                        let trackPrice = result["trackPrice"] as? Double {
                            let song = Song(id: id,
                                            trackName: trackName,
                                            trackPrice: trackPrice)
                        _songs.append(song)
                    }
                }
                
                self.songs = _songs
            }
        }
    }
}

