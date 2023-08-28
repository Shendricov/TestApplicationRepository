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

//MARK: делаем отслеживание нажатие и перетаскивание курсора по view. Для этого используем жест UIPanGesture  и добавляем его на нашу передвигаемую view.
// Отслеживание данного жеста будет только если нажать на передвигаемую view.
extension PanViewAnimationVC {

    private func appendPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        movingView.addGestureRecognizer(panGesture)
    }
    
    @objc private func panAction(recognise: UIPanGestureRecognizer) {
    
        switch recognise.state {
        case .changed:
//            метод показывает какое было смещение относительно точки нажатия.
            let translation = recognise.translation(in: self.view)
//            меняем положение передвигаемой view на величину смещения курсора
            movingView.frame.origin.x += translation.x
            movingView.frame.origin.y += translation.y
//            обнуляем значение текущего положения курсора, чтобы перемещение view было плавням.
            recognise.setTranslation(CGPoint.zero, in: self.view)
        default:
            let translation = recognise.translation(in: self.view)
        }
    }
}
