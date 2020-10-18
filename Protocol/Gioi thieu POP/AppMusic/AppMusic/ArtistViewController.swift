//
//  ArtistViewController.swift
//  AppMusic
//
//  Created by Pham Quang Huy on 8/16/17.
//  Copyright © 2017 Pham Quang Huy. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController {

    var items: [Artist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var artist1 = Artist()
        artist1.id = "159260351"
        artist1.name = "Taylor Swift"
        items.append(artist1)
        
        var artist2 = Artist()
        artist2.id = "102834"
        artist2.name = "Luis Fonsi"
        items.append(artist2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ArtistViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}

extension ArtistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let artist = items[indexPath.row]
        
        if let albumViewController = mainStoryboard.instantiateViewController(withIdentifier: "AlbumViewController") as? AlbumViewController {
            albumViewController.artist = artist
            self.navigationController?.pushViewController(albumViewController, animated: true)
        }
    }
}

