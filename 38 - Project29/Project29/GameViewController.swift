//
//  GameViewController.swift
//  Project29
//
//  Created by leticia.dayane on 23/05/24.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var currentGame: GameScene!

    @IBOutlet weak var angleSlider: UISlider!
    @IBOutlet weak var angleLabel: UILabel!
    @IBOutlet weak var velocitySlider: UISlider!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var launchButton: UIButton!
    @IBOutlet weak var playerNumber: UILabel!
    
    //challenge 1
    @IBOutlet weak var scorePlayerTwo: UILabel!
    @IBOutlet weak var scorePlayerOne: UILabel!
    
    var scoreOne: Int = 0 {
        didSet {
            scorePlayerOne.text = "Score: \(scoreOne)"
        }
    }
    
    var scoreTwo: Int = 0 {
        didSet {
            scorePlayerTwo.text = "Score: \(scoreTwo)"
        }
    }
    
    //challenge 3
    @IBOutlet weak var windOne: UILabel!
    @IBOutlet weak var windTwo: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //challenge 1
        scoreOne = 0
        scoreTwo = 0
        
        angleChanged(angleSlider!)
        velocityChanged(velocitySlider!)
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            //challenge 3
            applyRandomWindy(player: 1)
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
            applyRandomWindy(player: 1)
        } else {
            playerNumber.text = "PLAYER TWO >>>"
            applyRandomWindy(player: 2)
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    //challenge 1
    func updateScore(player: Int) {
        if player == 1 {
            scoreOne += 1
            scorePlayerOne.text = "Score: \(scoreOne)"
            
            if scoreOne == 3 {
                playerWins(player: 1)
            }
        } else if player == 2 {
            scoreTwo += 1
            scorePlayerTwo.text = "Score: \(scoreTwo)"
            
            if scoreTwo == 3 {
                playerWins(player: 2)
            }
        }
    }
    
    //challenge 1
    func playerWins(player: Int) {
        scoreOne = 0
        scoreTwo = 0
        
        let ac = UIAlertController(title: "Game Over", message: "Player \(player) Wins!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    //challenge 3
    func updateCurrentPlayerWindDirectionLabel(player: Int, windDirection: String) {
        if player == 1 {
            windOne.text = "Wind: \(windDirection)"
            windOne.isHidden = false
            windTwo.isHidden = true
        } else {
            windTwo.text = "Wind: \(windDirection)"
            windOne.isHidden = true
            windTwo.isHidden = false
        }
    }
    
    //challenge 3
    func applyRandomWindy(player: Int) {
        let windX = CGFloat.random(in: -0.5...0.5) //número horizontal aleatório
        let windY = CGFloat.random(in: -0.5...0.5) //número vertical aleatório
        self.currentGame.physicsWorld.gravity = CGVector(dx: windX, dy: windY)
        
        let windDirection = Wind(dx: windX, dy: windY).direction
        
        updateCurrentPlayerWindDirectionLabel(player: player, windDirection: windDirection)
    }
}
