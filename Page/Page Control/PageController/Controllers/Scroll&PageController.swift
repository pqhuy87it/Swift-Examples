//
//  Scroll&PageController.swift
//  PageController
//
//  Created by Summit on 06/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class Scroll_PageController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func backButton(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var characterViews: [CharacterView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterViews = CharacterView.loadAllView()
        pageControl.numberOfPages = characterViews.count
        setUpScrollView()
    }
    
    func setUpScrollView() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(characterViews.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0..<characterViews.count {
            characterViews[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(characterViews[i])
        }
    }

    
}

extension Scroll_PageController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/scrollView.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        
        let maxContentOffset = scrollView.contentSize.width - scrollView.frame.width
        let currentContentOffset = scrollView.contentOffset.x
        
        let percentContentOffset = currentContentOffset/maxContentOffset
        
        if percentContentOffset > 0 && percentContentOffset <= 0.166 {
            characterViews[0].imageView.transform = CGAffineTransform(scaleX: (0.166 - percentContentOffset) / 0.166 , y: (0.166 - percentContentOffset) / 0.166)
            characterViews[1].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/0.166, y: percentContentOffset/0.166)
        }else if percentContentOffset > 0.166 && percentContentOffset <= 0.333 {
            characterViews[1].imageView.transform = CGAffineTransform(scaleX: (0.333 - percentContentOffset) / 0.166 , y: (0.333 - percentContentOffset) / 0.166)
            characterViews[2].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/0.333, y: percentContentOffset/0.333)
        }else if percentContentOffset > 0.333 && percentContentOffset <= 0.5 {
            characterViews[2].imageView.transform = CGAffineTransform(scaleX: (0.5 - percentContentOffset) / 0.166 , y: (0.5 - percentContentOffset) / 0.166)
            characterViews[3].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/0.5, y: percentContentOffset/0.5)
        }else if percentContentOffset > 0.5 && percentContentOffset <= 0.666 {
            characterViews[3].imageView.transform = CGAffineTransform(scaleX: (0.666 - percentContentOffset) / 0.166 , y: (0.666 - percentContentOffset) / 0.166)
            characterViews[4].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/0.666, y: percentContentOffset/0.666)
        }else if percentContentOffset > 0.666 && percentContentOffset <= 0.833 {
            characterViews[4].imageView.transform = CGAffineTransform(scaleX: (0.833 - percentContentOffset) / 0.166 , y: (0.833 - percentContentOffset) / 0.166)
            characterViews[5].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/0.833, y: percentContentOffset/0.833)
        }else if percentContentOffset > 0.833 && percentContentOffset <= 1 {
            characterViews[5].imageView.transform = CGAffineTransform(scaleX: (1.0 - percentContentOffset) / 0.166 , y: (1.0 - percentContentOffset) / 0.166)
            characterViews[6].imageView.transform = CGAffineTransform(scaleX: percentContentOffset/1.0, y: percentContentOffset/1.0)
        }
        
    }
}
