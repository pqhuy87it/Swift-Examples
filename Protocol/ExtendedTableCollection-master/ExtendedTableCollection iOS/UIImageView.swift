//
//  UIImageView.swift
//  ExtendedTableCollection
//
//  Created by Basem Emara on 4/23/16.
//  Copyright © 2016 Zamzam Inc. All rights reserved.
//

import UIKit

public extension UIImageView {

    /**
     Asynchronously set an image with a URL.
     TODO: Replace with Kingfisher in real project: https://github.com/onevcat/Kingfisher

     - parameter URL: The URL of the image.
     */
    func setURL(_ URL: String) {
        guard let url = NSURL(string: URL) else { return }
        
        URLSession.shared.dataTask(with: url as URL) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, error == nil && httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async(execute: { () -> Void in
                self.image = image
            })
        }.resume()
    }
    
    
}
