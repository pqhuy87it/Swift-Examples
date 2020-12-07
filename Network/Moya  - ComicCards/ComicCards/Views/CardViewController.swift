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

import Foundation
import UIKit
import Kingfisher
import Moya

class CardViewController: UIViewController {
  // - MARK: - Dependencies
  private var comic: Comic?

  private let provider = MoyaProvider<Imgur>()
  private var uploadResult: UploadResult?

  // - MARK: - Outlets
  @IBOutlet weak private var lblTitle: UILabel!
  @IBOutlet weak private var lblDesc: UILabel!
  @IBOutlet weak private var lblChars: UILabel!
  @IBOutlet weak private var lblDate: UILabel!
  @IBOutlet weak private var image: UIImageView!
  @IBOutlet weak private var card: UIView!
  @IBOutlet weak private var progressBar: UIProgressView!
  @IBOutlet weak private var viewUpload: UIView!

  @IBOutlet weak private var btnShare: UIButton!
  @IBOutlet weak private var btnDelete: UIButton!

  private let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "MMM dd, yyyy"

    return df
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let comic = comic else { fatalError("Please pass in a valid Comic object") }

    layoutCard(comic: comic)
  }
}

// MARK: - Imgur handling
extension CardViewController {
  private func layoutCard(comic: Comic) {
    lblTitle.text = comic.title
    lblDesc.text = comic.description ?? "Not available"

    if comic.characters.items.isEmpty {
      lblChars.text = "No characters"
    } else {
      lblChars.text = comic.characters.items
                           .map { $0.name }
                           .joined(separator: ", ")
    }

    lblDate.text = dateFormatter.string(from: comic.onsaleDate)
    image.kf.setImage(with: comic.thumbnail.url)
  }

  @IBAction private func uploadCard() {
    UIView.animate(withDuration: 0.15) {
      self.viewUpload.alpha = 1.0
      self.btnShare.alpha = 0.0
      self.btnDelete.alpha = 0.0
    }

    progressBar.progress = 0.0

    let card = snapCard()
    provider.request(.upload(card),
                     callbackQueue: DispatchQueue.main,
                     progress: { [weak self] progress in
                      self?.progressBar.setProgress(Float(progress.progress), animated: true)
                     },
                     completion: { [weak self] response in
                      guard let self = self else { return }

                      UIView.animate(withDuration: 0.15) {
                        self.viewUpload.alpha = 0.0
                        self.btnShare.alpha = 0.0
                      }

                      switch response {
                      case .success(let result):
                        do {
                          let upload = try result.map(ImgurResponse<UploadResult>.self)

                          self.uploadResult = upload.data
                          self.btnDelete.alpha = 1.0

                          self.presentShare(image: card, url: upload.data.link)
                        } catch {
                          self.presentError()
                        }
                      case .failure:
                        self.presentError()
                      }
                    })
  }

  @IBAction private func deleteCard() {
    guard let uploadResult = uploadResult else { return }
    btnDelete.isEnabled = false

    provider.request(.delete(uploadResult.deletehash)) { [weak self] response in
      guard let self = self else { return }

      let message: String

      switch response {
      case .success:
        message = "Deleted successfully!"
        self.btnDelete.alpha = 0.0
      case .failure:
        message = "Failed deleting card! Try again later."
        self.btnDelete.isEnabled = true
      }

      let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Done", style: .cancel))

      self.present(alert, animated: true, completion: nil)
    }
  }
}

// MARK: - Helpers
extension CardViewController {
  static func instantiate(comic: Comic) -> CardViewController {
    guard let vc = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "ComicViewController") as? CardViewController else { fatalError("Unexpectedly failed getting ComicViewController from Storyboard") }

    vc.comic = comic

    return vc
  }

  private func presentShare(image: UIImage, url: URL) {
    let alert = UIAlertController(title: "Your card is ready!", message: nil, preferredStyle: .actionSheet)

    let openAction = UIAlertAction(title: "Open in Imgur", style: .default) { _ in
      UIApplication.shared.open(url)
    }

    let shareAction = UIAlertAction(title: "Share", style: .default) { [weak self] _ in
      let share = UIActivityViewController(activityItems: ["Check out my iMarvel card!", url, image],
                                           applicationActivities: nil)
      share.excludedActivityTypes = [.airDrop, .addToReadingList]
      self?.present(share, animated: true, completion: nil)
    }

    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

    alert.addAction(openAction)
    alert.addAction(shareAction)
    alert.addAction(cancelAction)

    present(alert, animated: true, completion: nil)
  }

  private func presentError() {
    let alert = UIAlertController(title: "Uh oh", message: "Something went wrong. Try again later.",
                                  preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    present(alert, animated: true, completion: nil)
  }

  private func snapCard() -> UIImage {
    UIGraphicsBeginImageContextWithOptions(card.bounds.size, true, UIScreen.main.scale)
    card.layer.render(in: UIGraphicsGetCurrentContext()!)
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Failed snapping card") }
    UIGraphicsEndImageContext()

    return image
  }
}
