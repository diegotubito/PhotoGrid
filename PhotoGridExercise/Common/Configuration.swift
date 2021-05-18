//
//  Configuration.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 18/05/2021.
//

import Foundation

class Configuration {
    static let shared = Configuration()
    
    static var measurementUnit: MeasurementUnit = .imperial
    
    static func setMeasurementUnit(value: MeasurementUnit) {
        Configuration.measurementUnit = value
    }
}
