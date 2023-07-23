//
//  SecondViewController.swift
//  TabBarApp
//
//  Created by Deep Arora on 8/16/18.
//  Copyright © 2018 Deep Arora. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet  weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let deviceWidth = UIScreen.main.bounds.size.width
        let cellSize = floor(deviceWidth / 8)
        let collectionViewWidth = 8 * cellSize
        self.collectionViewWidthConstraint.constant = collectionViewWidth
        //self.collectionView.layer.borderColor = UIColor.brown.cgColor
        
   
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return  64
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "unique", for: indexPath)
        
        let chessRow = indexPath.row / 8
        if chessRow % 2 == 0 {
            if indexPath.row % 2 == 0 {
                 cell.backgroundColor = UIColor.white
            }else{
                cell.backgroundColor = UIColor.black
            }
        } else{
            if indexPath.row % 2 == 0 {
                cell.backgroundColor = UIColor.black
            }else{
                cell.backgroundColor = UIColor.white
            }
        }
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 8.0
        let height = width
        return CGSize(width: width, height: height)
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

