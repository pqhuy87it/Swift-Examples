//
//  AlbumViewController.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.hidesWhenStopped = true
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    var artist: Artist?
    var items: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupInterface()
        loadData()
    }
    
    func setupInterface() {
        self.tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    func loadData() {
        activityIndicator.startAnimating()
        
        artist?.loadJSON(completion: { 
            if let album = self.artist?.albums {
                self.items.append(contentsOf: album)
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        })
    }
}

extension AlbumViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AlbumTableViewCell
        let album = items[indexPath.row]
        
        if let albumImage = album.imageValue {
            cell.albumImageView.image = albumImage
        } else if !album.isLoadingMedia {
            album.loadMedia(completion: {[weak self] in
                guard let weakSelf = self else {
                    return
                }
                
                if let albumImage = album.imageValue {
                    cell.albumImageView.image = albumImage
                }
                
                weakSelf.tableView.reloadRows(at: [indexPath], with: .none)
            })
            
            album.isLoadingMedia = true
        }
        
        cell.albumNameLabel.text = album.albumName
        cell.trackCountLabel.text = "\(album.trackCount ?? 0)"
        cell.priceLabel.text = "\(album.albumPrice ?? 0.0) $"
        cell.copyRightLabel.text = album.copyRight
        cell.selectionStyle = .none
        
        return cell
    }
}

extension AlbumViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = self.items[indexPath.row]
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let songViewController = mainStoryboard.instantiateViewController(withIdentifier: "SongViewController") as? SongViewController {
            songViewController.album = album
            self.navigationController?.pushViewController(songViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
