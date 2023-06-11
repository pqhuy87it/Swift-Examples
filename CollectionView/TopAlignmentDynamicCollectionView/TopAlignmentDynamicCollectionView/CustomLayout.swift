//
//  CustomLayout.swift
//  TopAlignmentDynamicCollectionView
//
//  Created by huy on 2023/06/11.
//

import Foundation
import UIKit

class CustomLayout: UICollectionViewFlowLayout {

    private var computedContentSize: CGSize = .zero
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
     var array = [String]()

    override var collectionViewContentSize: CGSize {
        return computedContentSize
    }

    override func prepare() {
        computedContentSize = .zero
        cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()

        var preY = 10
        var highY = 10

        for section in 0 ..< collectionView!.numberOfSections {
            var i = 0
            for item in 0 ..< collectionView!.numberOfItems(inSection: section) {
                let awidth =  Int((self.collectionView?.bounds.width)!) / 3 - 15
                let aheight = self.array[item].height(withConstrainedWidth: CGFloat(awidth), font: UIFont.systemFont(ofSize: 17)) + 20

                var aX = 10

                if item % 3 == 1 {
                    aX = aX + 10 + awidth
                }
                else if item % 3 == 2 {
                    aX = aX + 20 + 2 * awidth
                }
                else {
                    aX = 10
                    preY = highY
                }

                if highY < preY + Int(aheight) {
                    highY = preY + Int(aheight) + 5
                }

                let itemFrame = CGRect(x: aX, y: preY, width: awidth, height: Int(aheight))
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = itemFrame

                cellAttributes[indexPath] = attributes
                i += 1
            }
        }

        computedContentSize = CGSize(width: (self.collectionView?.bounds.width)!,
                                     height: CGFloat(highY))
    }


    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()

        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }

        return attributeList
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
}
