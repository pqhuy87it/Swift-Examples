//
//  ViewAnimationController.swift
//  Animations
//
//  Created by Pham Quang Huy on 12/11/16.
//  Copyright © 2016 Framgia, Inc. All rights reserved.
//

import UIKit

enum ViewAnimation: String {
    case SpringWithDamping
    case SpringWithDamping2
}

class ViewAnimationController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTableViewCell")
        }
    }
    
    let items = [ViewAnimation.SpringWithDamping.rawValue,
                 ViewAnimation.SpringWithDamping2.rawValue]
    
    let animationDuration: Double = 2.0
    let delayDuration: Double = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animate()
    }

    func animate() {

    }
    
    func makeAnimationDelay() {
        UIView.animate(withDuration: animationDuration, delay: delayDuration, options: [], animations: {
                self.imageView.frame.origin.y += 100
            }, completion: {finished in
        })
    }
    
    func makeAnimationLayoutSubviews() {
        UIView.animate(withDuration: animationDuration, delay: delayDuration, options: [.layoutSubviews], animations: {
            self.imageView.frame.origin.y += 100
            }, completion: {finished in
        })
    }
    
    func makeAnimationSpringDamping() {
        imageView.center.x += 30
        imageView.alpha = 0.0
        
        // change usingSpringWithDamping from 0.1 to 1.0 to see the difference
        UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
                self.imageView.center.x -= 30
                self.imageView.alpha = 1.0
            }, completion: nil)
    }
    
    func makeAnimationSpringDamping2() {
        imageView.alpha = 0.0
        
        // change usingSpringWithDamping from 0.1 to 1.0 to see the difference
        UIView.animate(withDuration: 3.0, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.imageView.bounds.size.width += 60.0
            self.imageView.bounds.size.height += 60.0
            self.imageView.alpha = 1.0
            }, completion: nil)
    }
}

extension ViewAnimationController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath as IndexPath) as! CustomTableViewCell
        let item = items[indexPath.row]
        cell.nameLabel.text = item
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewAnimationController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        switch item {
        case ViewAnimation.SpringWithDamping.rawValue:
            makeAnimationSpringDamping()
        case ViewAnimation.SpringWithDamping2.rawValue:
            makeAnimationSpringDamping2()
        default:
            break
        }
    }
}

