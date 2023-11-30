//
//  SearchViewController.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    private let viewModel = SearchViewModel()
    
    private var collectionView: UICollectionView!
    
    override func loadView() {
        let view = UIView()
        self.view = view
        view.backgroundColor = .systemBackground
    }
    
    // Custom text field with delayed closure
    // private let searchField = DelayedTextField()

    // Regular text field
    private let searchField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search Flickr"
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .secondarySystemFill
        
        configureSearchField()
        configureCollectionView()
        
        searchField.delegate = self
        
        // Bind to view model's data property and reload data in collection view on change
        viewModel.data.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }
        
        // Show error dialog
        viewModel.onErrorHandling = { error in
            DispatchQueue.main.async {
                let ac = UIAlertController(title: "An error occured", message: error, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        Task {
            await viewModel.fetchPhotos(for: self.searchField.text)
        }
        return true
    }
    
    private func configureSearchField() {
        view.addSubview(searchField)

// delayed text field
//        searchField.completion = { [weak self] in
//            Task {
//                await self?.viewModel.fetchPhotos(for: self?.searchField.text)
//            }
//        }
        searchField.placeholder = "Enter search terms, separated by commas"
        searchField.layer.borderColor = UIColor.systemGray4.cgColor
        searchField.layer.borderWidth = 1
        searchField.layer.cornerRadius = 10.0
        searchField.textColor = .label
        searchField.backgroundColor = .systemBackground
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            searchField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchField.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
        searchField.setLeftPaddingPoints(10)
        searchField.setRightPaddingPoints(10)
    }
    
    private func configureCollectionView() {
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
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        cell.configure(with: viewModel.data.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.photo = viewModel.data.value[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
