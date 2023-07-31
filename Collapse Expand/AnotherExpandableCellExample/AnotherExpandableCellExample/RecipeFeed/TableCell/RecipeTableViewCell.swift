//
//  File.swift
//  FoodCourt
//
//  Created by Максим Бойчук on 16.04.2020.
//  Copyright © 2020 Maksim Boichuk. All rights reserved.
//

import Foundation
import UIKit
//import Kingfisher
//import Cosmos
//import FirebaseUI

class CosmosView: UIView {
	
	var settings: UIImageView = UIImageView()
	var rating: Double = 0.0
}


class RecipeTableViewCell: UITableViewCell {
	
	@IBOutlet private weak var recipeNameLabel: UILabel?
	@IBOutlet private weak var recipeDescriptionLabel: UILabel?
	@IBOutlet private weak var recipeImageView: UIImageView?
	@IBOutlet private weak var ingredientsStackView: UIStackView?
	@IBOutlet private weak var recipeCosmosView: CosmosView?
	
	@IBOutlet weak var collapsedConstraint: NSLayoutConstraint?
	@IBOutlet weak var expandedConstraint: NSLayoutConstraint?
	
	private var isExpanded: Bool = false {
		didSet {
			guard let collapsedConstraint = collapsedConstraint, let expandedConstraint = expandedConstraint
				else { return }
			expandedConstraint.priority = isExpanded ? .defaultHigh : .defaultLow
			collapsedConstraint.priority = isExpanded ? .defaultLow : .defaultHigh
		}
	}
	
	//private var collapsedBorder: CGFloat = 0.0
	//private var expandedBorder: CGFloat = 0.0
	
	/*override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	super.init(style: style, reuseIdentifier: reuseIdentifier)
	setConstraints()
	}
	
	required init?(coder: NSCoder) {
	super.init(coder: coder)
	setConstraints()
	}*/
	
	override func prepareForReuse() {
		super.prepareForReuse()
		guard let recipeNameLabel = recipeNameLabel, let recipeDescriptionLabel = recipeDescriptionLabel,
			let recipeImageView = recipeImageView, let ingredientsStackView = ingredientsStackView
			else { return }
		recipeNameLabel.text = nil
		recipeDescriptionLabel.text = nil
		recipeImageView.image = nil
		ingredientsStackView.clean()
	}
	
	func configure(with recipe: Recipe) {
		guard let recipeNameLabel = recipeNameLabel, let recipeDescriptionLabel = recipeDescriptionLabel,
			let recipeImageView = recipeImageView, let recipeCosmosView = recipeCosmosView,
			let ingredientsStackView = ingredientsStackView
			else { return }
		recipeNameLabel.text = recipe.getName()
		recipeDescriptionLabel.text = recipe.getDescription()
		//let imageUrl = URL(string: recipe.imageData)
		//recipeImageView?.kf.setImage(with: imageUrl)
		recipeImageView.contentMode = .scaleAspectFill
		recipeImageView.layer.cornerRadius = 16
		recipeImageView.clipsToBounds = true
		//recipeCosmosView.settings.fillMode = .precise
		recipeCosmosView.rating = recipe.getRating()
		recipeCosmosView.isUserInteractionEnabled = false
		let ingredients = recipe.getIngredients()
		for ingredient in ingredients {
			let textLabel = UILabel()
			textLabel.backgroundColor = UIColor.yellow
			
			/*
			textLabel.widthAnchor.constraint(equalToConstant: ingredientsStackView.frame.width).isActive = true
			textLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
			*/
			
			textLabel.text  = ingredient.getName() + " " + String(ingredient.getAmount()) + " " + ingredient.getMeasure()
			textLabel.textAlignment = .left
			ingredientsStackView.addArrangedSubview(textLabel)
		}
		ingredientsStackView.translatesAutoresizingMaskIntoConstraints = false
		
		//collapsedBorder = recipeNameLabel.frame.maxY
		
		
		/*ingredientsStackView.getMaxYRegardingSuperview(completion: { [weak self] (maxY) in
		guard let self = self, let maxY = maxY else { return }
		self.expandedBorder = maxY
		print(maxY)
		})*/
		
		//expandedBorder = ingredientsStackView.getMaxYRegardingSuperview()
	}
	
	func setImage(image: UIImage) {
		guard let recipeImageView = recipeImageView else { return }
		recipeImageView.image = image
	}
}

extension RecipeTableViewCell {
    func setIsExpanded(isExpanded: Bool) { self.isExpanded = isExpanded }
    func getIsExpanded() -> Bool { return isExpanded }
    //func getCollapsedBorder() -> CGFloat { return collapsedBorder }
    //func getExpandedBorder() -> CGFloat { return expandedBorder }
    
    /*private func setConstraints() {
        guard var collapsedConstraint = collapsedConstraint, var expandedConstraint = expandedConstraint,
            let cellView = cellView, let ingredientsStackView = ingredientsStackView,
            let recipeNameLabel = recipeNameLabel, let recipeImageView = recipeImageView,
            let recipeDescriptionLabel = recipeDescriptionLabel, let recipeCosmosView = recipeCosmosView
            else { return }
        expandedConstraint = ingredientsStackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,
                                                                          constant: -8.0)
        collapsedConstraint = recipeNameLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8.0)
        expandedConstraint.priority = .defaultLow
        collapsedConstraint.priority = .defaultHigh
        let marginsGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: marginsGuide.topAnchor, constant: 0.0),
            cellView.leadingAnchor.constraint(equalTo: marginsGuide.leadingAnchor, constant: 0.0),
            cellView.trailingAnchor.constraint(equalTo: marginsGuide.trailingAnchor, constant: 0.0),
            cellView.bottomAnchor.constraint(equalTo: marginsGuide.bottomAnchor, constant: 0.0),
            
            recipeImageView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 0.0),
            recipeImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 0.0),
            recipeImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: 0.0),
            recipeImageView.heightAnchor.constraint(equalToConstant: 152.0),
            
            recipeNameLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8.0),
            recipeNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8.0),
            recipeNameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -175.0),
            
            recipeCosmosView.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 8.0),
            recipeCosmosView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 194.0),
            recipeCosmosView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8.0),
            
            recipeDescriptionLabel.topAnchor.constraint(equalTo: recipeNameLabel.bottomAnchor, constant: 8.0),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8.0),
            recipeDescriptionLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8.0),
            
            ingredientsStackView.topAnchor.constraint(equalTo: recipeDescriptionLabel.bottomAnchor, constant: 8.0),
            ingredientsStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8.0),
            ingredientsStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8.0),
            ingredientsStackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -8.0),

            expandedConstraint, collapsedConstraint,
        ])
    }*/
}

/*class IngredientsStackView: UIStackView {
    //private var maxYRegardingSuperView: CGFloat?
    
    private func removeChild(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func clean() {
        arrangedSubviews.forEach { (view) in
            removeChild(view: view)
        }
        //maxYRegardingSuperView = nil
    }
    
    /*func getMaxYRegardingSuperview(completion: ((CGFloat?) -> Void)?) {
        print("HERE")
        while maxYRegardingSuperView == nil {}
        print(maxYRegardingSuperView ?? "kek")
        completion?(maxYRegardingSuperView)
    }*/
    
    /*func getMaxYRegardingSuperview() -> CGFloat {
        print("HERE")
        //while maxYRegardingSuperView == nil {}
        guard let maxYRegardingSuperView = maxYRegardingSuperView else { return 0.0 }
        return maxYRegardingSuperView
        
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        maxYRegardingSuperView = self.frame.maxY
    }*/
}*/

extension UIStackView {
    private func removeChild(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    func clean() {
        arrangedSubviews.forEach { (view) in
            removeChild(view: view)
        }
    }
}
