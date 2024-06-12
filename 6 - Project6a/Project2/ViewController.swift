//
//  ViewController.swift
//  Project2
//
//  Created by leticia.dayane on 04/01/24.
//

import UIKit

class ViewController: UIViewController {
    
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
        
        // alteração no código para o auto layout em modo paisagem
        button1.setImage(UIImage(named: countries[0])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button2.setImage(UIImage(named: countries[1])?.withRenderingMode(.alwaysOriginal), for: .normal)
        button3.setImage(UIImage(named: countries[2])?.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        title = countries[correctAwnser].uppercased() + ", Your score is \(score)"
        
        //código para mostrar o resultado final
        count += 1
        
        if count > 10 {
            result = UIAlertController(title: "Congratulations! You completed the challenge", message: "Final score: \(score)", preferredStyle: .alert)
            present(result, animated: true)
            
        }
        
     
    }
    
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var ac: UIAlertController
        
        
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
    
    
}

