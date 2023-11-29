//
//  SearchViewController.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit

class SearchViewController: UIViewController {
    
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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
