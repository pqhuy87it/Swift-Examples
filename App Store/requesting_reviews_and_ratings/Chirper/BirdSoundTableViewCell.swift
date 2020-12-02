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
import AVKit

class BirdSoundTableViewCell: UITableViewCell {
  static let reuseIdentifier = String(describing: BirdSoundTableViewCell.self)

  @IBOutlet private var nameLabel: UILabel!
  @IBOutlet private var playbackButton: UIButton!
  @IBOutlet private var scientificNameLabel: UILabel!
  @IBOutlet private var countryLabel: UILabel!
  @IBOutlet private var dateLabel: UILabel!
  @IBOutlet private var audioPlayerContainer: UIView!
  
  private var playbackURL: URL?
  private let player = AVPlayer()
  
  private var isPlaying = false {
    didSet {
      let newImage = isPlaying ? #imageLiteral(resourceName: "pause") : #imageLiteral(resourceName: "play")
      playbackButton.setImage(newImage, for: .normal)
      if isPlaying, let url = playbackURL {
        startPlaying(with: url)
      } else {
        stopPlaying()
      }
    }
  }

  override func prepareForReuse() {
    defer { super.prepareForReuse() }
    isPlaying = false
  }
  
  @IBAction private func togglePlayback(_ sender: Any) {
    isPlaying = !isPlaying
  }
  
  func load(recording: Recording) {
    nameLabel.text = recording.friendlyName
    scientificNameLabel.text = recording.scientificName
    countryLabel.text = recording.country
    dateLabel.text = recording.date
    playbackURL = recording.playbackURL
  }

  private func startPlaying(with playbackURL: URL) {
    let playerItem = AVPlayerItem(url: playbackURL)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(didPlayToEndTime(_:)),
                                           name: .AVPlayerItemDidPlayToEndTime,
                                           object: playerItem)

    player.replaceCurrentItem(with: playerItem)
    player.play()

    AppStoreReviewManager.requestReviewIfAppropriate()
  }

  private func stopPlaying() {
    NotificationCenter.default.removeObserver(self,
                                              name: .AVPlayerItemDidPlayToEndTime,
                                              object: player.currentItem)

    player.pause()
    player.replaceCurrentItem(with: nil)
  }
  
  @objc private func didPlayToEndTime(_: Notification) {
    isPlaying = false
  }
}

