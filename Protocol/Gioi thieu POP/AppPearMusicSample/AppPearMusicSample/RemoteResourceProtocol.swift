//
//  RemoteResourceProtocol.swift
//  AppPearMusicSample
//
//  Created by Pham Quang Huy on 8/7/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol RemoteResource {}

public var dataCache: [String : NSData] = [:]

extension RemoteResource {
    func load(url: String, completion: ((_ success: Bool)->())?) {
        print("Performing request: ", url)
        
        let task = URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse, error == nil && data != nil {
                print("Response Code: %d", httpResponse.statusCode)
                
                dataCache[url] = data! as NSData
                if let completion = completion {
                    completion(true)
                }
            } else {
                print("Request Error")
                if let completion = completion {
                    completion(false)
                }
            }
        }
        task.resume()
    }
    
    func dataForURL(url: String) -> NSData? {
        // A real app would require a more robust caching solution.
        return dataCache[url]
    }
}

