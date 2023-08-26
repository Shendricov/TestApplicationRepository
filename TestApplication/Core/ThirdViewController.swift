//
//  ThirdViewController.swift
//  TestApplication
//
//  Created by Wally on 25.08.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
//  MARK:  make scrollView
    lazy private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        приравниваем границы самого skrollView с границам view на которой она располагается.
        scrollView.frame = self.view.bounds
        scrollView.contentSize = CGSize(width: self.view.safeAreaInsets.right, height: self.view.bounds.height + 100)
        return scrollView
    }()

}
