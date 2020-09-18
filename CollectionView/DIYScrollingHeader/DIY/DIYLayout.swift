//
//  DIYLayout.swift
//  DIY
//
//  Created by Mic Pringle on 10/03/2015.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//
//
// modified Dave Rothschild May 7, 2016

import UIKit

class DIYLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var deltaY: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! DIYLayoutAttributes
        copy.deltaY = deltaY
        
        return copy
    }
    
    override var hash: Int {
        return deltaY.hashValue
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? DIYLayoutAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        
        return false
    }
    
}

class DIYLayout: UICollectionViewFlowLayout {
    
    var maximumStretchHeight: CGFloat = 0
    
    override class var layoutAttributesClass: AnyClass {
        return DIYLayoutAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) as! [DIYLayoutAttributes]
        let insets = collectionView!.contentInset
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        if (offset.y < minY) {
            let deltaY = abs(offset.y - minY)
            for attributes in layoutAttributes {
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = min(max(minY, headerReferenceSize.height + deltaY), maximumStretchHeight)
                        frame.origin.y = frame.minY - deltaY
                        attributes.frame = frame
                        attributes.deltaY = deltaY
                    }
                }
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
