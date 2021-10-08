//
//  ViewController.swift
//  CustomLayouts
//
//  Created by Pramod Manjunath on 17/10/19.
//  Copyright © 2019 Pramod Manjunath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataSource: [[String]] = []
    
    // Set by constraints at the cell level. Currently hardcoding here. But can be derived from the actual constraints in the cell
    let cellLeftRightPadding: CGFloat = 32.0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatasource()
        setupCollectionView()
    }
}

// Extension for all private functions
private extension ViewController {
    func setupDatasource() {
        dataSource.append(generateRandomStringsArray(8))
        dataSource.append(generateRandomStringsArray(10))
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let pillLayout = PillLayout()
        pillLayout.delegate = self
        self.collectionView.collectionViewLayout = pillLayout
    }
    
    func generateRandomStringsArray(_ count: Int) -> [String] {
        var stringsArray: [String] = []
        let characterSet: CharacterSet = CharacterSet.alphanumerics
        print(count)
        for i in 0 ..< count {
            var internalString: String = ""
            for _ in 0 ... i+1 {
                internalString.append(characterSet.description.randomElement() ?? Character(""))
            }
            stringsArray.append(internalString)
        }
        return stringsArray.shuffled()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PillCell", for: indexPath) as? PillLayoutCollectionViewCell
        cell?.setLabel(dataSource[indexPath.section][indexPath.row])
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "PillHeader", for: indexPath) as? PillHeaderView
        header?.setupLabel("Section \(indexPath.section)")
        header?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        return header!
    }
}

extension ViewController: PillLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, sizeForPillAtIndexPath indexPath: IndexPath) -> CGSize {
        let label = dataSource[indexPath.section][indexPath.row]
        let referenceSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: PillLayoutCollectionViewCell.pillHeight)
        let calculatedSize = (label as NSString).boundingRect(with: referenceSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)], context: nil)
        return CGSize(width: calculatedSize.width + cellLeftRightPadding, height: PillLayoutCollectionViewCell.pillHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52.0
    }
    
    func collectionView(_ collectionView: UICollectionView, insetsForItemsInSection section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemSpacingInSection section: Int) -> CGFloat {
        return 12.0
    }
}
