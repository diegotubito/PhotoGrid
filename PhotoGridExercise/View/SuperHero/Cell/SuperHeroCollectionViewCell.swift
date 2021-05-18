//
//  SuperHeroCollectionViewCell.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 18/05/2021.
//

import UIKit

class SuperHeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
  
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(hero: SuperHeroData) {
        nameLabel.text = hero.name
        heightLabel.text = getProperValue(values: hero.appearance?.height)
        weightLabel.text = getProperValue(values: hero.appearance?.weight)
    }
    
    func setupPoster(image: UIImage) {
        posterImage.image = image
    }
    
    func getProperValue(values: [String]?) -> String {
        guard let values = values,
              !values.isEmpty else { return "" }
        return values[Configuration.measurementUnit.rawValue]
    }
}
