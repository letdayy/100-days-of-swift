//
//  ViewController.swift
//  HangmanGame
//
//  Created by leticia.dayane on 15/02/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guessWords: UILabel! //onde aparece as palavras
    @IBOutlet weak var remainingChances: UILabel! //pontuação
    @IBOutlet weak var guessButton: UIButton! //botão para inserir palavras
    
    var wordToGuess = "HELLO"
    var numberRemainingChances = 7
    var usedLetters = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        updateGuessWordsLabel()
        updateRemainingChancesLabel()
        
        guessButton.addTarget(self, action: #selector(guessAlert), for: .touchUpInside)
    }
    
    @objc func startGame() {
        
    }
    

    @objc func guessAlert() {
        let ac = UIAlertController(title: "Digite a letra", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Enviar", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
        let upperAnswer = answer.uppercased()
        
        //letra já foi utilizada
        if usedLetters.contains(upperAnswer) {
            let ac = UIAlertController(title: "Letra já utilizada", message: "Por favor, insira outra.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
            return
        }
        
        usedLetters.append(upperAnswer)
        
        if !wordToGuess.contains(upperAnswer) {
            numberRemainingChances -= 1
            
            let ac = UIAlertController(title: "Letra errada", message: "Tente novamente outra letra.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
        }
        
        if numberRemainingChances <= 0 {
            let ac = UIAlertController(title: "Fim de jogo", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            
            present(ac, animated: true)
        }
        
        updateGuessWordsLabel()
        updateRemainingChancesLabel()
    }
    
    func updateGuessWordsLabel() {
        var displayWord = ""
        
        for letter in wordToGuess {
            let strLetter = String(letter)
            
            if usedLetters.contains(strLetter) {
                displayWord += strLetter
            } else {
                displayWord += "_ "
            }
        }
        
        guessWords.text = displayWord
    }
    
    func updateRemainingChancesLabel() {
        remainingChances.text = "Chances restantes: \(numberRemainingChances)"
    }

}

