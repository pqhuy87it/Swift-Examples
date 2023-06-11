//
//  ViewController.swift
//  FloatingViewController
//
//  Created by yusuf demirkoparan on 4.10.2021.
//

import UIKit

class ViewController: FloatingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    @IBAction func test(_ sender: Any) {
     
    }
    
}

extension ViewController: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .Main }
}


class ViewController2: UIViewController, FloatingViewControllerDelegateProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    func viewDissmisModeIsEnable() -> Bool {
        return false
    }
    
    
    
    func viewContentHeight() -> CGFloat {
        return UIScreen.main.bounds.height*0.8
    }
    
    func viewExpandedHeight() -> CGFloat {
        return UIScreen.main.bounds.height*0.3
    }
    
    func viewClosedHeight() -> CGFloat {
        return UIScreen.main.bounds.height*0.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(NearbyPlaceCell.nib, forCellWithReuseIdentifier: NearbyPlaceCell.idendtifier)
        collectionview.dataSource = self
        collectionview.delegate = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = getExploreCollectionViewCell(collectionView, cellForItemAt: indexPath)
        return cell
    }
    
    func getExploreCollectionViewCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> NearbyPlaceCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NearbyPlaceCell.idendtifier,
                                                      for: indexPath) as! NearbyPlaceCell
        cell.setup()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("asdads")
    }
}

extension ViewController2: StoryboardInstantiate {
    static var storyboardType: StoryboardType { return .Main }
}

enum GestureDirection {
    case Up
    case Down
    case Left
    case Right
}
