//
//  ViewController.swift
//  TopAlignmentDynamicCollectionView
//
//  Created by huy on 2023/06/11.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var array = ["Hello", "Look Behind Look Behind Look Behind", "Gotta get there", "Hey buddy", "Earth is rotating around the sun Earth is rotating around the sun", "Sky is blue", "Kill yourself", "Humble docters", "Lets make party tonight Lets make party tonight Lets make party tonight Lets make party tonight", "Lets play PUB-G", "Where are you? Where are you? Where are you? Where are you? Where are you? Where are you? Where are you?", "Love you Iron Man."]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "MyCell",bundle: nil), forCellWithReuseIdentifier: "MyCell")
        let myLayout =  CustomLayout()
        myLayout.array = self.array
        collectionView.collectionViewLayout = myLayout
        collectionView.isScrollEnabled = false
        collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        print(collectionView.collectionViewLayout.collectionViewContentSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
            cell.myLabel.text = array[indexPath.row]
            cell.myLabel.layer.borderColor = UIColor.lightGray.cgColor
            cell.myLabel.layer.borderWidth = 1

            return cell

        }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }

    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }
}

