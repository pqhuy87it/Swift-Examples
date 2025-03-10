//
//  ImageViewModel.swift
//  StoriesLayout_Example
//
//  Created by Andrea Altea on 26/05/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol ImageCell {
    
    func set(image: UIImage)
    func set(index: Int)
}

struct ImageViewModel: ItemViewModel {
    
    var descriptor: ItemViewDescriptor
    var image: UIImage?
    
    var hashValue: Int {
        return image.hashValue
    }
    
    init(imageNamed name: String, cellDescriptor: ItemViewDescriptor) {
        self.descriptor = cellDescriptor
        self.image = UIImage(named: name)
    }
    
    func setup(_ view: UIView, in containerView: UIView, at indexPath: IndexPath) {
        guard let image = image else { return }
        (view as? ImageCell)?.set(image: image)
        (view as? ImageCell)?.set(index: indexPath.item)
    }
}
