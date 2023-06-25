//
//  ImageDownloader.swift
//  MVVMGitHubAPI
//
//  Created by 大西玲音 on 2021/04/04.
//

import Foundation
import UIKit

final class ImageDownloader {
    
    var catchImage: UIImage?
    
    func downloadImge(imageURL: String, handler: @escaping ResultHandler<UIImage>) {
        if let catchImage = catchImage {
            handler(.success(catchImage))
        }
        var request = URLRequest(url: URL(string: imageURL)!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    handler(.failure(error))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    handler(.failure(APIError.unknown))
                }
                return
            }
            guard let imageFromData = UIImage(data: data) else {
                DispatchQueue.main.async {
                    handler(.failure(APIError.unknown))
                }
                return
            }
            DispatchQueue.main.async {
                handler(.success(imageFromData))
            }
            self.catchImage = imageFromData
        }
        task.resume()
    }
    
}
