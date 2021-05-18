//
//  SuperHeroViewModel.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 18/05/2021.
//

import UIKit

protocol SuperHeroViewModelProtocol {
    init(withView view: SuperHeroViewProtocol)
    func loadSuperHeros()
    func loadImage(row: Int, completion: @escaping (UIImage?) -> ()) 
    func getHeroes() -> [SuperHeroData]
}

protocol SuperHeroViewProtocol {
    func showSuccess()
    func showImage(row: Int, image: UIImage)
    func showError(_ message: String)
}

class SuperHeroViewModel: SuperHeroViewModelProtocol {
    var model: SuperHeroModel
    var view: SuperHeroViewProtocol
    
    required init(withView view: SuperHeroViewProtocol) {
        self.view = view
        self.model = SuperHeroModel(heroes: [])
    }
    
    func loadSuperHeros() {
        let endpoint = Endpoint.Create(to: .superHero)
        ServerManager.ApiCall(endpoint: endpoint) { (heroes: [SuperHeroData]) in
            self.model.heroes = heroes
            self.view.showSuccess()
        } fail: { errorMessage in
            self.view.showError(errorMessage)
        }
    }
    
    func loadImage(row: Int, completion: @escaping (UIImage?) -> ()) {
        let hero = model.heroes[row]
        let endpoint = Endpoint.Create(to: .image(url: hero.images?.lg ?? ""))
        ServerManager.ApiCall(endpoint: endpoint) { data in
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        } fail: { errorMessage in
            completion(nil)
        }
    }
    
    func getHeroes() -> [SuperHeroData] {
        return model.heroes
    }
}
