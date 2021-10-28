//
//  ImageCollectionViewCell.swift
//  Gallery
//
//  Created by Георгий on 06.10.2021.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    private var imageCache: [String: UIImage] = [:]
    private let likeLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.pin.all()
        
        likeLabel.pin
            .hCenter()
            .vCenter()
            .height(60)
            .width(60)
            
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        likeLabel.text = ""
    }
    
    func configure(with urlString: String, with likesLabel: Int) {
        likeLabel.addTrailing(image: UIImage(systemName: "hand.thumbsup") ?? UIImage(), text: String(likesLabel))
        imageView.kf.setImage(with: URL(string: urlString))
        
    }
    
    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        contentView.addSubview(likeLabel)
    }
   
}
