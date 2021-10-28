//
//  PhotoDescriptionViewController.swift
//  Gallery
//
//  Created by Георгий on 11.10.2021.
//

import UIKit

class PhotoDescriptionViewController: UIViewController {

    private let imageView = UIImageView()
    private let tagsLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.pin
            .horizontally(60)
            .top(120)
            .height(400)
        
        tagsLabel.pin
            .hCenter()
            .below(of: imageView)
            .marginTop(30)
            .height(50)
            .width(view.frame.width)
    }
    
    private func setup() {
        title = "Photo description"
        view.backgroundColor = .white
        
        imageView.backgroundColor = .secondarySystemBackground
        tagsLabel.textAlignment = NSTextAlignment.center
        
        view.addSubview(imageView)
        view.addSubview(tagsLabel)
    }
    
    func configure(with urlString: String, with tagsLabel: String) {
        imageView.kf.setImage(with: URL(string: urlString))
        self.tagsLabel.text = tagsLabel
    }
    
}
