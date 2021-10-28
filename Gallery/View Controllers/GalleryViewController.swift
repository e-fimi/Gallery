//
//  ViewController.swift
//  Gallery
//
//  Created by Георгий on 06.10.2021.
//

import UIKit
import PinLayout

class GalleryViewController: UIViewController {
    var results: [Result] = []
    let urlString: String = "https://pixabay.com/api/?key=23733343-e31a2d7793aaf635f27b5122e"
    private let utilityQueue = DispatchQueue.global(qos: .utility)

    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPhotos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.pin.all()
    }
    
    func loadPhotos() {
        utilityQueue.async {
            
            guard let url = URL(string: self.urlString) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                do {
                    let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.results = jsonResult.hits
                        self?.collectionView.reloadData()
                    }
                }
                catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
    func setupCollectionView() {

        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageUrlString = results[indexPath.row].largeImageURL
        let likesLabel = results[indexPath.row].likes
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else {
            return .init()
        }
        
        cell.configure(with: imageUrlString, with: likesLabel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.bounds.width - 2
        let sideLength = availableWidth / 3
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hdImageUrl = results[indexPath.row].largeImageURL
        let tagsLabel = results[indexPath.row].tags
        let viewController = PhotoDescriptionViewController()
        viewController.configure(with: hdImageUrl, with: tagsLabel)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
}
