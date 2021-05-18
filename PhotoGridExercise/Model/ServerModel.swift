//
//  EndpointModel.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import Foundation

class EndpointModel {
    var url : String
    var method : String
    
    init(url: String, method: String) {
        self.url = url
        self.method = method
    }
}
