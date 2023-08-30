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

//MARK: Append pan gesture for moving view and animate it.
extension PanViewAnimationVC {

    private func appendPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        movingView.addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(recognise: UIPanGestureRecognizer) {
    
        switch recognise.state {
        case .changed:
            
//       rotation moving view
            rotationView()
            
//      получаем координаты смещения курсора.
            let translation = recognise.translation(in: self.view)
//      меняем положение view  на величину смещения курсора
            
            movingView.frame.origin.x += translation.x
            movingView.frame.origin.y += translation.y
            

            
//      reset translation point to zero.
            recognise.setTranslation(.zero, in: self.view)
            
//      animate back to the rect view.
        default:
            if movingView.frame.minX < 0 {
                UIView.animate(withDuration: 0.2) {
                    self.movingView.frame.origin.x = 10
                }
            } else if movingView.frame.maxX > self.view.bounds.width {
                UIView.animate(withDuration: 0.2) {
                    self.movingView.frame.origin.x = self.view.bounds.width - self.movingView.bounds.width - 10
                }
            } else if movingView.frame.minY < 0 {
                UIView.animate(withDuration: 0.2) {
                    self.movingView.frame.origin.y = 10
                }
            } else if movingView.frame.maxY > self.view.bounds.height {
                UIView.animate(withDuration: 0.2) {
                    self.movingView.frame.origin.y = self.view.bounds.height - self.movingView.bounds.height - 10
                }
            }
        }
    }
}

//      animate shadow and rotation movingView.
extension PanViewAnimationVC {
   private func  animateShadow(with translation: CGPoint ) {
        let currentPositionShadow = movingView.layer.shadowOffset
        let xOffSet = currentPositionShadow.width - translation.x
        let yOffSet = currentPositionShadow.height - translation.y
        
        movingView.layer.shadowOffset = CGSize(width: xOffSet, height: yOffSet)
        
        var valueX: CGFloat = .zero
        var valueY: CGFloat = .zero
        
        if translation.x < 0 {
            valueX = -translation.x / 10
            valueY = translation.y / 10
        } else if translation.y < 0 {
            valueY = -translation.y / 10
            valueX = translation.x / 10
        }
        movingView.layer.shadowRadius += ((valueX + valueY) / 2)
    }
    
    private func rotationView() {
        let chengePosition = self.view.center.x - self.movingView.center.x
        let divKoef = self.view.frame.width / 2 * 0.6
        
        self.movingView.transform = CGAffineTransform(rotationAngle: chengePosition / divKoef)
    }
}
