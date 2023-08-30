//
//  ThirdViewController.swift
//  TestApplication
//
//  Created by Wally on 25.08.2023.
//

import UIKit

class ScrollViewVC: UIViewController {

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
        
//    MARK: 2. make vertical stack
    private var vStackView: UIStackView = {
       let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
// MARK: append button for back tranzit.
    lazy var buttonBack = {
        let button = UIButton()
        button.frame.size = CGSize(width: 300, height: 20)
        button.setTitle("<--- BACK", for: .normal)
        button.backgroundColor = .systemCyan
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.addTarget(self, action: #selector(backButton), for: .touchUpInside)
        return button
    }()
    
//    MARK: очень важная особенность scrollView она привязывается своими границами к границам view на котором располагается, а вот его вшутренние размеры или contentSize зависит от размера объектов, которые располагаются внутри scrollView. Поэтому привязка и размеры всех объектов внутри scrollView должны быть полностью определены.
    
   @objc private func backButton() {
//       указываем стиль анимации при переходе.
       self.modalTransitionStyle = .coverVertical
//       сам переход путем удаления текущего контроллера из иерархии
       self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(vStackView)
        setupColors()
        setupViewConstraints()
    }
    
}

extension ScrollViewVC {
    private func setupViewConstraints() {
        
        scrollView.addSubview(buttonBack)
        buttonBack.translatesAutoresizingMaskIntoConstraints = false
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            vStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            vStackView.bottomAnchor.constraint(equalTo: buttonBack.topAnchor, constant: -30)
        ])
        for view in vStackView.arrangedSubviews {
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
                view.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        NSLayoutConstraint.activate([
            buttonBack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            buttonBack.widthAnchor.constraint(equalToConstant: 300),
            buttonBack.heightAnchor.constraint(equalToConstant: 30),
            buttonBack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
    }
    
    private func setupColors() {
        let colors = [UIColor.red, .blue, .yellow, .green]
        for index in 0..<10 {
            let currentView = UIView()
            currentView.backgroundColor = colors[index % colors.count]
            vStackView.addArrangedSubview(currentView)
        }
    }
}
