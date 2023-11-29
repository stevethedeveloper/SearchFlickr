//
//  ImageCollectionViewCell.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionCell"
    
    var text = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        
        self.addSubview(text)
        text.numberOfLines = 0
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.numberOfLines = 0
        text.textColor = .label
        setTextLabelConstraints()
    }
    
    func setTextLabelConstraints() {
        text.translatesAutoresizingMaskIntoConstraints                                                  = false
        text.topAnchor.constraint(equalTo: topAnchor).isActive                             = true
        text.heightAnchor.constraint(equalToConstant: 60).isActive                                      = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive                    = true
        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive                 = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
