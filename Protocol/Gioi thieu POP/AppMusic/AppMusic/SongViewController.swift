//
//  SongViewController.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var album: Album?
    var items = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupInterface()
        
        self.album?.loadJSON(completion: { [weak self] in
            guard let weakSelf = self else {
                return
            }
            
            guard let song = weakSelf.album?.songs else {
                return
            }
            
            weakSelf.items = song
            weakSelf.tableView.reloadData()
        })
    }

    func setupInterface() {
        tableView.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

}

extension SongViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let song = items[indexPath.row]
        cell.textLabel?.text = "\(song.trackName ?? "No Name")   price: \(song.trackPrice ?? 0.0) $"
        cell.selectionStyle = .none
        return cell
    }
}
