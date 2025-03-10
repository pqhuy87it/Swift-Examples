//
//  ViewController.swift
//  StoriesLayout
//
//  Created by oni.zerone@gmail.com on 05/25/2019.
//  Copyright (c) 2019 oni.zerone@gmail.com. All rights reserved.
//

import UIKit

class DemoController: UIViewController {

    var defaultImages = ["storiesLayout/001",
                         "storiesLayout/002",
                         "storiesLayout/003",
                         "storiesLayout/004",
                         "storiesLayout/005",
                         "storiesLayout/006",
                         "storiesLayout/001",
                         "storiesLayout/002",
                         "storiesLayout/003",
                         "storiesLayout/004",
                         "storiesLayout/005",
                         "storiesLayout/006"]
    
    var layout: UICollectionViewLayout
    var cellDescriptor: ItemViewDescriptor
    
    weak var collectionView: UICollectionView!
    var dataSource: CollectionBinderDataSource!
    
    init(layout: UICollectionViewLayout, cellDescriptor: ItemViewDescriptor) {
        self.layout = layout
        self.cellDescriptor = cellDescriptor
        super.init(nibName: nil, bundle: nil)
        
        self.title = String(describing: type(of: layout.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("you should not create from xib")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        setupCells()
        setupDataSource()
    }
    
    func setupCollection() {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        view.addSubview(collection)
        
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collection.topAnchor).isActive = true
        view.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: collection.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: collection.rightAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collection.bottomAnchor).isActive = true
        collectionView = collection
    }
    
    func setupCells() {
        collectionView.register(UINib(nibName: cellDescriptor.reuseIdentifier,
                                      bundle: .main), forCellWithReuseIdentifier: cellDescriptor.reuseIdentifier)
    }
    
    func setupDataSource() {
        let section = ConcreteSection(items:
            defaultImages.map { ImageViewModel(imageNamed: $0, cellDescriptor: self.cellDescriptor) })
        
        dataSource = CollectionBinderDataSource(view: collectionView, model: [section])
     }
}
