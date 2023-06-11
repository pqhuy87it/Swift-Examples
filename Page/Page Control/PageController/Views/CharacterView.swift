//
//  CharacterView.swift
//  PageController
//
//  Created by Summit on 08/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit

class CharacterView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptView.layer.cornerRadius = 10
    }

}

extension CharacterView {
    static func loadAllView() -> [CharacterView] {
        let characters = Character.loadData()
        var views = Array<CharacterView>()
        
        for character in characters {
            let view = Bundle.main.loadNibNamed("CharacterView", owner: nil, options: nil)?.first as! CharacterView
            view.imageView.image = character.image
            view.titleLabel.text = character.name
            view.descriptionLabel.text = character.description
            
            views.append(view)
        }
        return views
    }
}
