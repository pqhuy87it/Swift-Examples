//
//  ListViewController.swift
//  StoriesLayout_Example
//
//  Created by Andrea Altea on 02/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//
import UIKit

class ListViewController: UIViewController {

    weak var collectionView: UICollectionView!
    var dataSource: GridCollectionDataSource!
    
    var layouts: [ItemViewModel] = [
        LayoutItemViewModel(descriptor:MyStoriesCollectionViewCell.Descriptor()) { StoriesCollectionViewLayout() },
        LayoutItemViewModel(descriptor:MySafariCollectionViewCell.Descriptor()) { SafariCollectionViewLayout() }
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        setupCells()
        setupDataSource()
    }
    
    func setupCollection() {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        view.addSubview(collection)
        
        view.topAnchor.constraint(equalTo: collection.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: collection.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: collection.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: collection.rightAnchor).isActive = true
        self.collectionView = collection
    }
    
    func setupCells() {
        layouts.forEach { item in
            self.collectionView.register(UINib(nibName: item.descriptor.reuseIdentifier,
                                               bundle: Bundle.main),
                                         forCellWithReuseIdentifier: item.descriptor.reuseIdentifier)
        }
    }
    
    func setupDataSource() {
        self.dataSource = GridCollectionDataSource(view: collectionView,
                                                   model: [ConcreteGridSection(items: layouts)])
        self.dataSource.interactionDelegate = self
    }
}

extension ListViewController: InteractionFactory {
    var context: UIViewController {
        return self
    }
}
