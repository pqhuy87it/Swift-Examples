//
//  UserCellViewModel.swift
//  MVVMGitHubAPI
//
//  Created by 大西玲音 on 2021/04/04.
//

//ImageDownloaderからユーザーのiconをダウンロードする
//Imageダウンロード中か、ダウンロード終了か、エラーかの状態をもち、通知を送る
//cellの見た目に反映させるアウトプットをする

import Foundation
import UIKit

enum ImageDownloadProgress {
    case loading(UIImage)
    case finish(UIImage)
    case error
}

final class UserCellViewModel {
    
    private var user: User
    private let imageDownloader = ImageDownloader()
    private var isLoading = false
    var nickName: String {
        return user.name
    }
    var webUrl: URL {
        return URL(string: user.webUrl)!
    }
    init(user: User) {
        self.user = user
    }
    
    func downloadImage(progress: @escaping (ImageDownloadProgress) -> Void) {
        if isLoading {
            return
        } else {
            isLoading.toggle()
        }
        let loadingImage = UIImage(color: .gray, size: CGSize(width: 45, height: 45))!
        progress(.loading(loadingImage))
        imageDownloader.downloadImge(imageURL: user.iconUrl) { result in
            switch result {
            case .success(let image):
                progress(.finish(image))
                self.isLoading = false
            case .failure(_):
                progress(.error)
                self.isLoading = false
            }
        }
    }
}
