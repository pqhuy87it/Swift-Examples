//
//  Recipe.swift
//  FoodCourt
//
//  Created by Максим Бойчук on 16.04.2020.
//  Copyright © 2020 Maksim Boichuk. All rights reserved.
//

import Foundation
import UIKit

public struct Recipe {
    private let id: String
    private let authorId: String
    private let name: String
    private let description: String
    private var image: UIImage?
    private let rating: Double
    private let ingredients: [Ingredient]
    
    init(id: String, authorId: String, name: String, description: String, rating: Double,
         ingredients: [Ingredient]) {
        self.id = id
        self.authorId = authorId
        self.name = name
        self.description = description
        self.rating = rating
        self.ingredients = ingredients
        self.image = UIImage()
    }
    
    mutating func setImage(image: UIImage) { self.image = image }
    
    func getId() -> String { return id }
    func getAuthorId() -> String { return authorId }
    func getName() -> String { return name }
    func getDescription() -> String { return description }
    func getImage() -> UIImage? { return image }
    func getRating() -> Double { return rating }
    func getIngredients() -> [Ingredient] { return ingredients }
}
