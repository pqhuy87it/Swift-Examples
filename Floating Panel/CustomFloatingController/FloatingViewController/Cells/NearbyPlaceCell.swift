//
//  NearbyPlaceCell.swift
//  PetalMaps
//
//  Created by Arda Ersoy on 12.10.2021.
//

import UIKit

/// A collection view cell to present nearby places of a location.
class NearbyPlaceCell: UICollectionViewCell {
    
	// MARK: - View Elements
    @IBOutlet private weak var placeImageView: UIImageView!
    @IBOutlet private weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
	/**
	 It configures the place image and name.
	 - Parameters:
	   - place: a resultable protocol for nearby search
	 */
    func setup() {
        
        placeNameLabel.text = "place.name"
    }
}

// MARK: - UINib and Identifier
extension NearbyPlaceCell {
	
    static var nib: UINib {
        return UINib(nibName: idendtifier, bundle: nil)
    }
    
    static var idendtifier: String {
        return String(describing: self)
    }
}

// MARK: - Nearby Place Cell Constants
struct NearbyPlaceCellConstants {
    static var nearbyPlaceHoldeIconName: String = "icon_nearby_placeholder"
}
