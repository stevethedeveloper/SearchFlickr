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
    
//    var text = UILabel()
    var imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
//        self.addSubview(text)
//        text.numberOfLines = 0
//        text.font = UIFont.boldSystemFont(ofSize: 16)
//        text.numberOfLines = 0
//        text.textColor = .label
//        setTextLabelConstraints()
        
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints                                             = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive                                = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive                              = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive                            = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive                                = true
    }
    
    public func configure(with photo: Photo) {
        self.imageView.sd_setImage(with: URL(string: photo.photoUrl), placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority, context: nil, progress: nil)

    }
    
//    func setTextLabelConstraints() {
//        text.translatesAutoresizingMaskIntoConstraints                                                  = false
//        text.topAnchor.constraint(equalTo: topAnchor).isActive                             = true
//        text.heightAnchor.constraint(equalToConstant: 60).isActive                                      = true
//        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive                    = true
//        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive                 = true
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
