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
        // Do any additional setup after loading the view.
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

