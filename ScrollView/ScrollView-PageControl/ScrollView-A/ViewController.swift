//
//  ViewController.swift
//  ScrollView-A
//
//  Created by Horacio Gomes dos Santos Junior on 20/03/23.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    var animating = false
    
    var redView : UIView!
    var greenView : UIView!
    
    let numberOfPages = 4
    var width: CGFloat!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        width = scrollView.bounds.width
        widthConstraint.constant = width * CGFloat(numberOfPages)
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = 0
        
        greenView.frame = CGRect(origin: CGPoint(x: width * 1, y: 0.0), size: CGSize(width: width, height: width))
        
        redView.frame = CGRect(origin: CGPoint(x: width * 3, y: 0.0), size: CGSize(width: width, height: width))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        greenView = UIView(frame: CGRect.zero)
        greenView.backgroundColor = UIColor.green
        container.addSubview(greenView)
        
        redView = UIView(frame: CGRect.zero)
        redView.backgroundColor = UIColor.red
        container.addSubview(redView)
        
        pageControl.addTarget(self, action: #selector(paged), for: UIControl.Event.valueChanged)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if(!animating){
            let xOrigin = scrollView.contentOffset.x
            
            let nextPage : Int = Int( round(xOrigin / width))
            pageControl.currentPage = nextPage
        }
        
    }
    
    @objc func paged(sender : UIPageControl) -> Void{
        animating = true
        let nextPage = sender.currentPage
        let newFrame = CGRect(origin: CGPoint(x: CGFloat(nextPage) * width, y: 0.0), size: CGSize(width: width, height: width))
        
        scrollView.scrollRectToVisible(newFrame, animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        animating = false
    }
    
    
    
}

