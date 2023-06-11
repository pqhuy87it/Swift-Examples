//
//  CardViewController.swift
//  PageController
//
//  Created by Summit on 27/10/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class CardView: UIViewController {
    
    var cardView: UIView
    var countLabel: UILabel
    var pageIndex: Int?
    
    init() {
        cardView = UIView(frame: .zero)
        countLabel = UILabel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(cardView)
        cardView.addSubview(countLabel)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 175).isActive = true
        cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.96).isActive = true
        cardView.backgroundColor = .red
        cardView.layer.cornerRadius = 8
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        countLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        countLabel.textColor = .white
        countLabel.font = UIFont.boldSystemFont(ofSize: 21)
    }
    

}
