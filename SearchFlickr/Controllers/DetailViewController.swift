//
//  DetailViewController.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/29/23.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    var photo: Photo?
    private let imageView = UIImageView()
    private let placeholderImage = UIImage(named: "placeholder")
    private let titleLabel = UILabel()
    private let sizeLabel = UILabel()
    private let authorLabel = UILabel()
    private let tagsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .secondarySystemFill

        // Image
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        // SDWebImage
        if let photo = photo {
            imageView.sd_setImage(with: URL(string: photo.photoUrl), placeholderImage: placeholderImage, options: SDWebImageOptions.highPriority, context: nil, progress: nil)
        }


        // Info
        view.addSubview(titleLabel)
        view.addSubview(sizeLabel)
        view.addSubview(authorLabel)
        view.addSubview(tagsLabel)

        titleLabel.text = "Title: \(photo?.title ?? "Unknown")"
        titleLabel.font = .systemFont(ofSize: 20)
        sizeLabel.text = "Size: \(String(format: "%.1f", (imageView.image?.size.width ?? "Unknown"))) x \(String(format: "%.1f", (imageView.image?.size.height ?? "Unknown")))"
        sizeLabel.font = .systemFont(ofSize: 20)
        authorLabel.text = "Author: \(String(photo?.author ?? "Unknown"))"
        authorLabel.font = .systemFont(ofSize: 20)
        tagsLabel.text = "Tags: \(String(photo?.tags ?? "Unknown"))"
        tagsLabel.font = .systemFont(ofSize: 20)

        // Set constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),

            sizeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            sizeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sizeLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            sizeLabel.heightAnchor.constraint(equalToConstant: 20),

            tagsLabel.topAnchor.constraint(equalTo: sizeLabel.bottomAnchor, constant: 10),
            tagsLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tagsLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tagsLabel.heightAnchor.constraint(equalToConstant: 20),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
