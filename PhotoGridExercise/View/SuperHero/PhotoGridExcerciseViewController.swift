//
//  ViewController.swift
//  PhotoGridExercise
//
//  Created by David Diego Gomez on 16/05/2021.
//

import UIKit

class PhotoGridExcerciseViewController: UIViewController {
    var viewModel: SuperHeroViewModelProtocol!
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        viewModel.loadSuperHeros()
        setupCollectionView()
    }
    
    private func setupVC() {
        viewModel = SuperHeroViewModel(withView: self)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let size = CGSize(width: view.frame.width / 2, height: view.frame.height/3)
        layout.itemSize = size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(SuperHeroCollectionViewCell.nib, forCellWithReuseIdentifier: SuperHeroCollectionViewCell.identifier)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "An error occured", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Accept", style: .default, handler: nil))
  
        self.present(alert, animated: true)
    }
}

extension PhotoGridExcerciseViewController: SuperHeroViewProtocol {
    func showImage(row: Int, image: UIImage) {
        DispatchQueue.main.async {
            let index = IndexPath(row: row, section: 0)
            self.collectionView.reloadItems(at: [index])
        }
    }
    
    func showSuccess() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.showErrorAlert(message: message)
        }
    }
}

extension PhotoGridExcerciseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getHeroes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuperHeroCollectionViewCell.identifier, for: indexPath) as? SuperHeroCollectionViewCell else {
            return UICollectionViewCell()
        }
        let hero = viewModel.getHeroes()[indexPath.row]
        cell.setup(hero: hero)
        cell.posterImage.image = nil
        cell.activityIndicator.startAnimating()
        viewModel.loadImage(row: indexPath.row) { image in
            DispatchQueue.main.async {
                cell.activityIndicator.stopAnimating()
                guard let image = image else { return }
                cell.posterImage.image = image
            }
        }
        return cell
    }
}
