//
//  ViewController.swift
//  TestApplication
//
//  Created by Wally on 23.08.2023.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var buttonTranzitSecondScene: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        decorateButtonTitle()
    }
//MARK: Через тип таймера устанавливаем рассписание вызова метода.
    func decorateButtonTitle() {
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(setColorForButtonTitle), userInfo: nil, repeats: true)
    }
//    данный метод меняет аттрибуты текста названия кнопки. В нашем случае меняется цвет текста.
    @objc private func setColorForButtonTitle() {
        var randomeNumber: CGFloat { CGFloat.random(in: 0...1) }
        let color = UIColor(red: randomeNumber, green: randomeNumber, blue: randomeNumber, alpha: 1)
        let attributeText = NSAttributedString(string: "To the second scene", attributes: [NSAttributedString.Key.foregroundColor : color])
        buttonTranzitSecondScene.setAttributedTitle(attributeText, for: .normal)
    }
    
//MARK:    Три способа переходить между сценами: Segue, Present & Navigation Controller.
//    Ниже реализуем Present.
    @IBAction func tranzitSecondScene() {
//        Получаем экземпляр сцены, к которой хотим перейти, из Storyboard.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destenationScene = storyboard.instantiateViewController(identifier: "second VC") as? SecondViewController else { return }
//        здесь определяем как будет осуществлена анимация перехода.
        destenationScene.modalTransitionStyle = .coverVertical
//        здесь определяем как будет отображаться новая сцена.
        destenationScene.modalPresentationStyle = .currentContext
        self.present(destenationScene, animated: true)
    }
    deinit {
        print("start VC deinit")
    }
}

