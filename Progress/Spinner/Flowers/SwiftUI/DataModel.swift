/// Copyright (c) 2021 Razeware LLC
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
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class DataModel: NSObject, ObservableObject {
  @Published var progress: Float = 0
	@Published var image: UIImage?
	var activeDownload: Download?
	var downloadSession: URLSession {
		let config = URLSessionConfiguration.background(withIdentifier: "background")
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil
		let queue = OperationQueue()
		return URLSession(configuration: config, delegate: self, delegateQueue: queue)
	}
}

extension DataModel: DownloadDelegate {
	func downloadProgressUpdated(for progress: Float) {
		DispatchQueue.main.async {
			self.progress = progress
		}
	}

	func download(with url: URL) {
		activeDownload = Download(url: url)
		guard let activeDownload = activeDownload else { return }
		activeDownload.delegate = self
		activeDownload.downloadTask = downloadSession.downloadTask(with: url)
		activeDownload.downloadTask?.resume()
	}
}

extension DataModel: URLSessionDownloadDelegate {
	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
		if let data = try? Data(contentsOf: location) {
			let image = UIImage(data: data)
			DispatchQueue.main.async {
				self.image = image
			}
		}
	}

	func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
		if let download = activeDownload {
			download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
		}
	}
}
