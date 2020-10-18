//
//  MeidaResource.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/31/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import Foundation
import UIKit

protocol MediaResource: RemoteResource {
}

extension MediaResource where Self: Album {
    var mediaURL: String {
        return self.albumUrlImage ?? ""
    }
    
    var imageValue: UIImage? {
        if let imageData = self.dataForURL(url: self.mediaURL) {
            return UIImage(data: imageData as Data)
        }
        
        return nil
    }
    
    func loadMedia(completion: (() -> ())?) {
        load(url: self.mediaURL) { success in
            if let completion = completion {
                DispatchQueue.main.async(execute: completion)
            }
        }
    }
}
