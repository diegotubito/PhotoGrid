//
//  ServerManager.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import Foundation
import Alamofire

class ServerManager {
    public static var baseUrl = "https://dev.consultr.net/superhero.json"
    
    private init () {}
 
    static func ApiCall(endpoint: EndpointModel, success: @escaping (Data) -> (), fail: @escaping (String) ->()) {
        Call(endpoint: endpoint) { data in
            success(data)
        } fail: { errorMessage in
            fail(errorMessage)
        }
    }
    
    static func ApiCall<T: Decodable>(endpoint: EndpointModel, success: @escaping (T) -> (), fail: @escaping (String) ->()) {
        Call(endpoint: endpoint) { data in
            do {
                let genericData = try JSONDecoder().decode(T.self, from: data)
                success(genericData)
            } catch {
                fail("serialization error")
            }
        } fail: { errorMessage in
            fail(errorMessage)
        }
    }
    
    private static func Call(endpoint: EndpointModel, success: @escaping (Data) -> (), fail: @escaping (String) ->()) {
        guard let url = URL(string: endpoint.url) else {
            fail("URL error")
            return
        }
        
        Alamofire.request(url, method: .get).response { response in
            guard response.error == nil else {
                fail(response.error?.localizedDescription ?? "Some error ocurred")
                return
            }
            
            guard let data = response.data else {
                fail("No data fetched")
                return
            }
            
           
            success(data)
        }
    }

}
