/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

struct PhotoManagerNotification{
  // Notification when new photo instances are added
  static let contentAdded = Notification.Name("com.raywenderlich.GooglyPuff.PhotoManagerContentAdded")
  // Notification when content updates (i.e. Download finishes)
  static let contentUpdated = Notification.Name("com.raywenderlich.GooglyPuff.PhotoManagerContentUpdated")
}

struct PhotoURLString{
  // Photo Credit: Devin Begley, http://www.devinbegley.com/
  static let overlyAttachedGirlfriend = "https://i.imgur.com/UvqEgCv.png"
  static let successKid = "https://i.imgur.com/dZ5wRtb.png"
  static let lotsOfFaces = "https://i.imgur.com/tPzTg7A.jpg"
}

typealias PhotoProcessingProgressClosure = (_ completionPercentage: CGFloat) -> Void
typealias BatchPhotoDownloadingCompletionClosure = (_ error: NSError?) -> Void

class PhotoManager {
  private init() {}
  static let shared = PhotoManager()
  
  private let concurrentPhotoQueue =
    DispatchQueue(
      label: "com.raywenderlich.GooglyPuff.photoQueue",
      attributes: .concurrent)
  
  private var unsafePhotos: [Photo] = []
  
  var photos: [Photo] {
    var photosCopy: [Photo]!
    concurrentPhotoQueue.sync {
      photosCopy = self.unsafePhotos
    }
    return photosCopy
  }
  
  func addPhoto(_ photo: Photo) {
    concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
      guard let self = self else {
        return
      }
      self.unsafePhotos.append(photo)
      DispatchQueue.main.async { [weak self] in
        self?.postContentAddedNotification()
      }
    }
  }
  
  func downloadPhotos(withCompletion completion: BatchPhotoDownloadingCompletionClosure?) {
    var storedError: NSError?
    let downloadGroup = DispatchGroup()
    var addresses = [PhotoURLString.overlyAttachedGirlfriend,
                     PhotoURLString.successKid,
                     PhotoURLString.lotsOfFaces]
    addresses += addresses + addresses
    var blocks: [DispatchWorkItem] = []

    for index in 0..<addresses.count {
      downloadGroup.enter()
      let block = DispatchWorkItem(flags: .inheritQoS) {
        let address = addresses[index]
        let url = URL(string: address)
        let photo = DownloadPhoto(url: url!) { _, error in
          if error != nil {
            storedError = error
          }
          downloadGroup.leave()
        }
        PhotoManager.shared.addPhoto(photo)
      }
      blocks.append(block)
      DispatchQueue.main.async(execute: block)
    }

    for block in blocks[3..<blocks.count] {
      let cancel = Bool.random()
      if cancel {
        block.cancel()
        downloadGroup.leave()
      }
    }

    downloadGroup.notify(queue: DispatchQueue.main) {
      completion?(storedError)
    }
  }
  
  private func postContentAddedNotification() {
    NotificationCenter.default.post(name: PhotoManagerNotification.contentAdded, object: nil)
  }
}
