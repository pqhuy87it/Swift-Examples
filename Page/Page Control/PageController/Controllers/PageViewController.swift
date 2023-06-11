//
//  ViewController.swift
//  PageController
//
//  Created by Summit on 27/10/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var datas = [1, 2, 3, 4, 5, 6]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        setViewControllers([viewControllerForPage(at: 0)], direction: .forward, animated: false, completion: nil)
    }


}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CardView, let pageIndex = viewController.pageIndex, pageIndex > 0 else {
            return nil
        }
        return viewControllerForPage(at: pageIndex - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? CardView, let pageIndex = viewController.pageIndex, pageIndex + 1 < datas.count else {
            return nil
        }
        return viewControllerForPage(at: pageIndex + 1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return datas.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let viewControllers = pageViewController.viewControllers, let currentVC = viewControllers.first as? CardView, let currentIndex = currentVC.pageIndex else {
            return 0
        }
        return currentIndex
    }
    
    private func viewControllerForPage(at index: Int) -> UIViewController {
        let vc = CardView()
        vc.pageIndex = index
        vc.countLabel.text = "\(datas[index])"
        return vc
    }
    
    
    
}

