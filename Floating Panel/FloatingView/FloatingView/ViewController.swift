//
//  ViewController.swift
//  FloatingView
//
//  Created by youngjun goo on 2020/04/21.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit

private let identifier = "cellIdentifier"

class ViewController: UIViewController {
    
    let images:[UIImage] = [#imageLiteral(resourceName: "train"),#imageLiteral(resourceName: "pin"),#imageLiteral(resourceName: "arrow")]
    var searchView = BottomSearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.dataSource = self
        searchView.delegate = self

        searchView.placeholder = "장소 또는 주소 검색"
        searchView.searchBarStyle = .minimal
        searchView.tableView.backgroundColor = .clear
        searchView.contentView.layer.cornerRadius = 10
        searchView.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)

        let nib = UINib(nibName: "SearchTableViewCell", bundle: .main)
        searchView.tableView.register(nib, forCellReuseIdentifier: identifier)
        view.addSubview(searchView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: BottomSearchDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! SearchTableViewCell

        cell.placeLabel.text = "지역이름 \(indexPath.row)"
        cell.addressLabel.text = "주소 텍스트"
        cell.backgroundColor = .clear

        let image = images[indexPath.row % images.count]
        cell.imageView?.image = image.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = .white
        cell.circleView.backgroundColor = .red
        cell.circleView.layer.cornerRadius = cell.circleView.frame.width/2
        cell.selectionStyle = .none

        return cell
    }
}

extension ViewController: BottomSearchViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

