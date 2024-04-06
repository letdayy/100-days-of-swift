//
//  ViewController.swift
//  Project2
//
//  Created by leticia.dayane on 04/01/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    let center = UNUserNotificationCenter.current()
    
    //chamando os botões
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    //inicializando as variáveis
    var countries = [String]()
    var score = 0
    var correctAwnser = 0
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scheduleNotications()
        

        //colocando uma borda nas bandeiras
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        /*alterando a cor da borda
        precisa converter para cgColor para o botão poder entender
         */
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
 
        //consertando o problema da imagem menor que a borda
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        //adicionando os nomes no array
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        let result: UIAlertController
        
        countries.shuffle()
        
        correctAwnser = Int.random(in: 0...2)
        
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        
        title = countries[correctAwnser].uppercased() + ", Your score is \(score)"
        
        //código para mostrar o resultado final
        count += 1
        
        if count > 10 {
            result = UIAlertController(title: "Congratulations! You completed the challenge", message: "Final score: \(score)", preferredStyle: .alert)
            result.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.count = 0
                self.score = 0
                self.askQuestion()
            }))
            present(result, animated: true)
            
        }
        
     
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var ac: UIAlertController
        
        //challenge project15
        UIView.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            //reverte o tamanho do botão
            UIView.animate(withDuration: 0.2, animations: {
                sender.transform = CGAffineTransform.identity
            })
        }
        
        if sender.tag == correctAwnser {
            title = "Correct!"
            score += 1
            
            ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        } else {
            title = "Wrong :c"
            
            ac = UIAlertController(title: title, message: "That’s the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            
        }
        
    
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
       
    }
    
    //challenge 3 project 21
    func scheduleNotications() {
        center.removeAllPendingNotificationRequests()
        
        for i in 1...7 {
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "Don't forget to play today!"
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60 * 60 * 24 * i), repeats: false)
            
            let request = UNNotificationRequest(identifier: "dailyReminder\(i)", content: content, trigger: trigger)
        }
    }
    
    
}

