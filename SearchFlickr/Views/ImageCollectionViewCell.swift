//
//  ImageCollectionViewCell.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionCell"
    
    private let placeholderImage = UIImage(named: "placeholder")
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let imageViewConstraints = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(imageViewConstraints)        
    }
    
    // Call this to set up the cell
    public func configure(with photo: Photo) {
        self.imageView.sd_setImage(with: URL(string: photo.photoUrl), placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority, context: nil, progress: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
