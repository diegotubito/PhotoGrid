//
//  Endpoint.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import UIKit

enum EndpointType {
    case superHero
    case image(url: String)
}

class Endpoint {
    static func Create(to: EndpointType) -> EndpointModel {
        switch to {
        case .superHero:
            let url = ServerManager.baseUrl
            return EndpointModel(url: url, method: "GET")
        case .image(url: let url):
            return EndpointModel(url: url, method: "GET")
        }
    }
}

