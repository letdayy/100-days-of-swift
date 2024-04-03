//
//  ViewController.swift
//  Project21
//
//  Created by leticia.dayane on 03/04/24.
//

import UserNotifications
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {
            (granted, error) in
            if granted {
                print("Yes!")
            } else {
                print("No :(")
            }
        })
    }
    
    @objc func scheduleLocal() {
        
    }

}

