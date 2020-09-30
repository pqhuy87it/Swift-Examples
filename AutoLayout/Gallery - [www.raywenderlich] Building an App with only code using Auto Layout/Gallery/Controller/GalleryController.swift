/// Copyright (c) 2019 Razeware LLC
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

class GalleryController: UIViewController {
  lazy var cardView1: CardView = {
    let cardView = CardView(with: .skeleton)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView2: CardView = {
    let cardView = CardView(with: .owl)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView3: CardView = {
    let cardView = CardView(with: .panda)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  lazy var cardView4: CardView = {
    let cardView = CardView(with: .monkey)
    cardView.translatesAutoresizingMaskIntoConstraints = false
    return cardView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
    view.backgroundColor = .white
  }
  
  // MARK: - Setting Views
  private func setupViews() {
    view.addSubviews(cardView1, cardView2, cardView3, cardView4)
  }
  
  // MARK: - Setting Constraints
  private func setupConstraints() {
    let safeArea = view.safeAreaLayoutGuide

    NSLayoutConstraint.activate([
      cardView1.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      cardView1.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView1.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView1.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),

      cardView2.leadingAnchor.constraint(equalTo: cardView1.trailingAnchor),
      cardView2.topAnchor.constraint(equalTo: safeArea.topAnchor),
      cardView2.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView2.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),
      cardView2.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

      cardView3.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
      cardView3.topAnchor.constraint(equalTo: cardView1.bottomAnchor),
      cardView3.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView3.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),
      cardView3.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),

      cardView4.leadingAnchor.constraint(equalTo: cardView3.trailingAnchor),
      cardView4.topAnchor.constraint(equalTo: cardView2.bottomAnchor),
      cardView4.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
      cardView4.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.5),
      cardView4.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
    ])
  }
}
