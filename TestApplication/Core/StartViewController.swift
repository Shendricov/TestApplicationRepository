//
//  ViewController.swift
//  TestApplication
//
//  Created by Wally on 23.08.2023.
//

import UIKit

protocol ChangeBackgroundColorProtocol {
    func changeBackgroundColor(color: UIColor)
}

class StartViewController: UIViewController {

    @IBOutlet weak var buttonTranzitSecondScene: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        first decoration of button
        buttonTranzitSecondScene.isHidden = true
        buttonTranzitSecondScene.alpha = 0
        progressView.progress = 0
        
        addNotificationForBackgroundcolor()
        decorateButtonTitle()
        animationLoadStartVC()
    }

    
//MARK:    Три способа переходить между сценами: Segue, Present & Navigation Controller.
//    Ниже реализуем Present.
    @IBAction func tranzitSecondScene() {
//  получаем в виде кода информацию о всех настройках приложения произведенного на storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        Получаем экземпляр сцены, из Storyboard, к которой хотим перейти.
        guard let destenationScene = storyboard.instantiateViewController(identifier: "second VC") as? SecondViewController else { return }
//        передаем себя в качестве делегата, при вызове этого метода цвет фона первой сцены бедет изменен.
        destenationScene.delegate = self
//        здесь определяем как будет осуществлена анимация перехода.
        destenationScene.modalTransitionStyle = .coverVertical
//        здесь определяем как будет отображаться новая сцена.
        destenationScene.modalPresentationStyle = .currentContext
        self.present(destenationScene, animated: true)
    }
    deinit {
        print("start VC deinit")
    }
    
    @IBAction func transiteThirdScene(_ sender: Any) {
    }
    
}
//MARK: add protocol delegate
extension StartViewController: ChangeBackgroundColorProtocol {
    func changeBackgroundColor(color: UIColor) {
        view.backgroundColor = color
    }
}

//MARK: Через тип таймера устанавливаем рассписание вызова метода.
extension StartViewController {
    
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
}


//MARK: add notification
extension StartViewController {
    private func addNotificationForBackgroundcolor() {
        let notificationName = Notification.Name("setRedBackgroundColor")
        NotificationCenter.default.addObserver(self, selector: #selector(setColorBackground), name: notificationName, object: nil)
    }
    @objc private func setColorBackground(_ notification: Notification) {
        guard let color = notification.userInfo?["BackgroundColor"] as? UIColor else { return }
        self.view.backgroundColor = color
                
    }
}


//MARK: add load animation
extension StartViewController {
   
    private func animationLoadStartVC() {
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
    @objc private func setProgress() {
        
        if progressView.progress != 1 {
            progressView.setProgress(progressView.progress + 1, animated: true)
            let persentCompleted = progressView.progress / 1 * 100
            self.loadingLabel.text! = "Loading app ....... \(Int(persentCompleted))%"
        } else {
            buttonTranzitSecondScene.isHidden = false
            self.loadingLabel.text = "Completed"
            self.progressView.isHidden = true
            UIView.animate(withDuration: 0.8) {
                self.buttonTranzitSecondScene.alpha = 1
            }
        }
        
    }
}
