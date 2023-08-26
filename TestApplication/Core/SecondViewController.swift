//
//  SecondViewController.swift
//  TestApplication
//
//  Created by Wally on 23.08.2023.
//

import UIKit

class SecondViewController: UIViewController {

    var delegate: ChangeBackgroundColorProtocol?
//    MARK: инзменяем цвет заднего фона первой сцены при момощи делегата
    @IBAction private func setGreenColorDelegate() {
        guard let delegate = delegate else { return }
        delegate.changeBackgroundColor(color: .systemGreen)
        self.dismiss(animated: true)
    }
    //    MARK: инзменяем цвет заднего фона первой сцены при момощи уведомления
    @IBAction private func setRedColorNotification() {
        let notificationName = Notification.Name("setRedBackgroundColor")
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: ["BackgroundColor" : UIColor.systemRed])
        self.dismiss(animated: true)
    }
    
    deinit {
        print("second scene deinit")
    }
    
    
    //    MARK: переходим на экран со scrollView
    @IBAction func toTheThirdScene() {
        let destination: UIViewController = ThirdViewController()
        self.present(destination, animated: true)
    }
    
}
