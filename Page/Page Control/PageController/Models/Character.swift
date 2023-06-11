//
//  Character.swift
//  PageController
//
//  Created by Summit on 07/11/20.
//  Copyright © 2020 BhabaniShankar. All rights reserved.
//

import UIKit


struct Character: Decodable {
    let name: String
    let description: String
    var image: UIImage?
    
    enum Codingkeys: String, CodingKey {
        case name, description, image_Name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        description = try container.decode(String.self, forKey: .description)
        let imageName = try container.decode(String.self, forKey: .image_Name)
        image = UIImage(named: imageName)
    }
}

extension Character {
    static func loadData() -> [Character] {
        guard let fileUrl = Bundle.main.url(forResource: "Characters_Info", withExtension: "plist") else { fatalError("Error on accessing plist file") }
        
        do {
            let characterData = try Data.init(contentsOf: fileUrl)
            let charaters = try PropertyListDecoder().decode([Character].self, from: characterData)
            return charaters
        }catch let error {
            fatalError(error.localizedDescription)
        }
    }
}
