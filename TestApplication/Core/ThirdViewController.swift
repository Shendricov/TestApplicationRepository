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
        self.view.addSubview(scrollView)
        configureScrollView()
    }
    
    private var contentSize: CGSize {
        CGSize(width: self.view.bounds.width, height: self.view.bounds.width + 100)
    }
    
//  MARK:  make scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        приравниваем границы самого skrollView с границам view на которой она располагается.
        scrollView.frame = self.view.bounds
//        пртравниваем контент размер скролл по ширине ко вью и по выстоте более вью на сто точек.
        scrollView.contentSize = contentSize
        return scrollView
    }()

    private func contentView() -> UIView {
        let colorBascet = [UIColor.red, .blue, .yellow, .purple]
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 300),
            contentView.heightAnchor.constraint(equalToConstant: 50)
        ])
        contentView.backgroundColor = colorBascet.randomElement()
        return contentView
    }
    
    
    private func configureScrollView() {
        let vStack = UIStackView()
        scrollView.addSubview(vStack)
        vStack.frame = scrollView.bounds
        for _ in 0...30 {
            let contentView = contentView()
            vStack.addArrangedSubview(contentView)
        }
    }
}
