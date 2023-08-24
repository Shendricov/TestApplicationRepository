//
//  SecondViewController.swift
//  TestApplication
//
//  Created by Wally on 23.08.2023.
//

import UIKit

class SecondViewController: UIViewController {

    var delegate: ChangeBackgroundColorProtocol?
    
    @IBAction private func setGreenColorDelegate() {
        guard let delegate = delegate else { return }
        delegate.changeBackgroundColor(color: .systemGreen)
        self.dismiss(animated: true)
    }
    
    @IBAction private func setRedColorNotification() {
        
    }
    
    deinit {
        print("second scene deinit")
    }
}
