//
//  WordCell.swift
//  BlueDomain
//
//  Created by Faizyy on 25/03/20.
//  Copyright © 2020 faiz. All rights reserved.
//

import UIKit

class WordCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.masksToBounds = false

        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        self.textLabel.textAlignment = .center
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        
    }
    
    override func dragStateDidChange(_ dragState: UICollectionViewCell.DragState) {

        switch dragState {
        case .none:
            self.layer.opacity = 1
        case .lifting:
            return
        case .dragging:
            self.layer.opacity = 0

        @unknown default:
            fatalError("Did not implement")
        }
    }
    
}
