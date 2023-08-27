//
//  ThirdViewController.swift
//  TestApplication
//
//  Created by Wally on 25.08.2023.
//

import UIKit

class ThirdViewController: UIViewController {

    private var contentSize: CGSize {
        CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 100)
    }
    
//  MARK: 1. make scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        приравниваем границы самого skrollView с границам view на которой она располагается.
        scrollView.frame = self.view.bounds
//        пртравниваем контент размер скролл по ширине ко вью и по выстоте более вью на сто точек.
//        scrollView.contentSize = contentSize
        return scrollView
    }()
    
//MARK: 2. make content
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.frame.size = contentSize
        return contentView
    }()
    
//    MARK: 3. make vertical stack
    private var vStackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//        contentView.addSubview(vStackView)
        scrollView.addSubview(vStackView)
        setupColors()
        setupViewConstraints()
    }
    
}

extension ThirdViewController {
    private func setupViewConstraints() {
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
//            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            vStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
//            vStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
        for view in vStackView.arrangedSubviews {
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
                view.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
    
    private func setupColors() {
        let colors = [UIColor.red, .blue, .yellow, .green]
        for index in 0..<100 {
            let currentView = UIView()
            currentView.backgroundColor = colors[index % colors.count]
//            currentView.backgroundColor = colors.randomElement()
            vStackView.addArrangedSubview(currentView)
        }
    }
}
