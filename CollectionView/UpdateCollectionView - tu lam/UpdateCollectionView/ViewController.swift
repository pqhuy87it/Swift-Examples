//
//  ViewController.swift
//  UpdateCollectionView
//
//  Created by Exlinct on 11/30/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit
import PromiseKit

class ViewController: UIViewController {
    private let CellIdentifier = "cellidentifier"

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNib(UINib(nibName: "CustomCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
            collectionView.backgroundColor = UIColor.whiteColor()
        }
    }
    let songDataProvider = SongDataProvider()
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getDataSong()
    }

    func getDataSong() {
        songDataProvider.getWestlifeSongs().then { songs in
                self.completeLoadSongs(songs)
            }.error { error in
                print(error)
        }
        
    }
    
    func loadMoreSongs() {
        songDataProvider.getTaylorSwiftSongs().then { songs in
            self.comleteLoadMoreSongs(songs)
        }
    }
    
    func completeLoadSongs(songs: [SongModel]) -> Promise<Void> {
        return Promise { complete, failure in
            let songNames = songs.flatMap{ $0.trackName }
            self.items.removeAll()
            self.items.appendContentsOf(songNames)
            self.collectionView.reloadData()
            
            complete()
        }
        
    }
    
    func comleteLoadMoreSongs(songs: [SongModel]) -> Promise<Void> {
        return Promise { compete, failure in
            let songNames = songs.flatMap{ $0.trackName }
            
            // create array index path
            var indexPathsInsert = [NSIndexPath]()
            
            for songName in songNames {
                let indexPath = NSIndexPath(forItem: self.items.count, inSection: 0)
                
                indexPathsInsert.append(indexPath)
                self.items.append(songName)
            }
            
            self.collectionView.performBatchUpdates({[weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.collectionView.insertItemsAtIndexPaths(indexPathsInsert)
                
            }, completion: nil)
            
            compete()
        }
    }
    
    @IBAction func loadMorePressed(sender: AnyObject) {
        self.loadMoreSongs()
    }
}


//*****************************************************************
// MARK: - UICollectionViewDataSource
//*****************************************************************

extension ViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellIdentifier
            , forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.nameLabel.text = items[indexPath.row]
        return cell
    }
    
}


//*****************************************************************
// MARK: - UICollectionViewDelegate
//*****************************************************************

extension ViewController:  UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath)  {
    }
    
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        return CGSizeMake(80.0, 50.0)
    }
}
