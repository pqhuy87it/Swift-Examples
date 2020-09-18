//
//  ViewController.swift
//  TableViewHeaderScale
//
//  Created by 陈凡 on 16/5/19.
//  Copyright © 2016年 湖南省 永州市 零陵区 湖南科技学院. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var imageView:UIImageView!
    let imageHeight:CGFloat = 136
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        imageView = UIImageView(frame: CGRect(x: 0, y: -imageHeight, width: self.view.frame.width, height: imageHeight))
        imageView.image = UIImage(named: "2.JPG")
        imageView.contentMode = .scaleAspectFill
        self.tableView.addSubview(imageView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: imageHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -imageHeight)
        imageView.clipsToBounds = true
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let point = scrollView.contentOffset
        if point.y < -imageHeight {
            var rect = imageView.frame
            rect.origin.y = point.y
            rect.size.height = -point.y
            imageView.frame = rect
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

