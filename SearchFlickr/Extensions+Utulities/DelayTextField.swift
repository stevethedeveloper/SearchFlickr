//
//  DelayTextField.swift
//  SearchFlickr
//
//  Created by Stephen Walton on 11/28/23.
//

import UIKit

class DelayedTextField: UITextField {
    var delay: Double = 1.0
    var timer: Timer?
    var completion: (() -> Void)?
    
    convenience init() {
        self.init(frame: .zero)
        self.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    @objc func valueChanged() {
        timer?.invalidate()
        // set timer for completion handler
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(executeAction), userInfo: nil, repeats: false)
    }
    
    // execute completion handler
    @objc func executeAction() {
        if let completion = completion {
            completion()
        }
    }
}
