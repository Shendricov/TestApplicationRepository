//
//  PanViewAnimationVC.swift
//  TestApplication
//
//  Created by Wally on 28.08.2023.
//

import UIKit

class PanViewAnimationVC: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(movingView)
        appendPanGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setConstraint()
    }
    
    lazy var movingView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemMint
        
//        operation with layer
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 10, height: -10)
    
        return view
    }()
//    set start position on root view.
   private func setConstraint() {
                movingView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    movingView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
                    movingView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                    movingView.widthAnchor.constraint(equalToConstant: 100),
                    movingView.heightAnchor.constraint(equalToConstant: 100)
                ])
    }
   
}


extension PanViewAnimationVC {

    private func appendPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        movingView.addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(recognise: UIPanGestureRecognizer) {
    
        switch recognise.state {
        case .began:
            print("begin")
        case .changed:
            print("change")
        case .ended:
            print("end")
        default:
            print("other state")
        }
    }
}
