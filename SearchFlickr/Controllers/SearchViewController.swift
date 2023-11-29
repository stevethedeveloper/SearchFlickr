//
//  SearchViewController.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    var data = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    
    private var collectionView: UICollectionView!
    
    
    
    // Custom text field with delayed closure
    private let titleField = DelayedTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Flickr"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .systemRed
        
        titleField.layer.borderColor = UIColor.systemGray4.cgColor
        titleField.layer.borderWidth = 1
        titleField.layer.cornerRadius = 10.0
        titleField.textColor = .label
        titleField.backgroundColor = .systemBackground
        
        view.addSubview(titleField)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleField.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        titleField.setLeftPaddingPoints(10)
        titleField.setRightPaddingPoints(10)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(150, 150)
        layout.scrollDirection = .vertical
        layout.collectionView?.alwaysBounceVertical = true
        layout.collectionView?.isScrollEnabled = true
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)

        
        
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.text.text = data[indexPath.row]
        return cell
    }
    
    
}
