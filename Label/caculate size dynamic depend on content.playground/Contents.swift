import UIKit
import PlaygroundSupport

let mainView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 375, height: 500)))
mainView.backgroundColor = .red
PlaygroundPage.current.liveView = mainView

let v = UILabel()
v.numberOfLines = 0
v.text = "TestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTestingTesting"
v.translatesAutoresizingMaskIntoConstraints = false
v.backgroundColor = .green
mainView.addSubview(v)

NSLayoutConstraint.activate([
    v.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 3.0 / 10.0),
    v.leftAnchor.constraint(equalTo: mainView.leftAnchor),
    v.topAnchor.constraint(equalTo: mainView.topAnchor),
//    v.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
    ])

mainView.setNeedsLayout()
mainView.layoutIfNeeded()

v.frame

v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
