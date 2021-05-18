//
//  SuperHeroModel.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import Foundation

struct SuperHeroModel {
    var heroes: [SuperHeroData]
}

struct SuperHeroData: Decodable {
    var id: Int?
    var name: String?
    var images: ImageModel?
    var appearance: AppearanceModel?
}

struct ImageModel: Decodable {
    var xs: String?
    var sm: String?
    var md: String?
    var lg: String?
}

struct AppearanceModel: Decodable {
    var height: [String]?
    var weight: [String]?
}


