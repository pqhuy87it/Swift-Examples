//
//  HomeViewController.swift
//  PageController
//
//  Created by Summit on 05/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var cellViews: [UIColor] = [.purple, .red, .orange, .green, .systemPink, .cyan, .gray, .yellow, .blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let childVC = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        pageController.numberOfPages = cellViews.count
        
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        addChild(childVC)
        childVC.didMove(toParent: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "collectioncell", for: indexPath) as! CollectionViewCell
        cell.imageView.backgroundColor = cellViews[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/collectionView.bounds.width)
        pageController.currentPage = Int(pageIndex)
        
    }
}
