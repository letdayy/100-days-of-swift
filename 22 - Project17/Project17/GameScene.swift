//
//  GameScene.swift
//  Project17
//
//  Created by leticia.dayane on 20/03/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield: SKEmitterNode!
    var player: SKSpriteNode!
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    let possibleEnemies = ["ball", "hammer", "tv"]
    var isGameOver = false
    var gameTimer: Timer?
    
    //extra
    var gameOverLabel: SKLabelNode?
    var backButton: SKShapeNode?
    
    //challenge 2
    var enemyCount = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 1024, y: 384)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        
    }
    
    @objc func createEnemy() {
        //challenge 2
        guard enemyCount < 20 else {
            adjustTimerInterval()
            enemyCount = 0
            return
        }
        
        enemyCount += 1
        
        //challenge 3
        if !isGameOver {
            guard let enemy = possibleEnemies.randomElement() else { return }
            
            let sprite = SKSpriteNode(imageNamed: enemy)
            sprite.position = CGPoint(x: 1200, y: Int.random(in: 50...736))
            addChild(sprite)
            
            sprite.physicsBody = SKPhysicsBody(texture: sprite.texture!, size: sprite.size)
            sprite.physicsBody?.categoryBitMask = 1
            sprite.physicsBody?.velocity = CGVector(dx: -500, dy: 0)
            sprite.physicsBody?.angularVelocity = 5
            sprite.physicsBody?.linearDamping = 0
            sprite.physicsBody?.angularDamping = 0
        }
    }
    
    //challenge 2
    func adjustTimerInterval() {
        gameTimer?.invalidate()
        
        let newInterval = max(0.25, gameTimer?.timeInterval ?? 0.35 - 0.1)
        gameTimer = Timer.scheduledTimer(timeInterval: newInterval, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < -300 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        var location = touch.location(in: self)
        
        if location.y < 100 {
            location.y = 100
        } else if location.y > 668 {
            location.y = 668
        }
        
        player.position = location
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = player.position
        addChild(explosion)
        
        player.removeFromParent()
        
        isGameOver = true
        
        gameOverLabel = SKLabelNode(text: "Game Over")
        gameOverLabel?.fontName = "Chalkduster"
        gameOverLabel?.fontSize = 50
        gameOverLabel?.position = CGPoint(x: size.width/2, y: size.width/2)
        
        if let gameOverLabel = gameOverLabel {
            addChild(gameOverLabel)
        }
        
        //botão voltar
        let backButtonSize = CGSize(width: 200, height: 50)
        backButton = SKShapeNode(rectOf: backButtonSize, cornerRadius: 10)
        backButton?.position = CGPoint(x: size.width/2, y: size.height/2 - 50)
        backButton?.fillColor = SKColor.black
        
        //adicionar texto no botão voltar
        let backButtonText = SKLabelNode(text: "Back")
        backButtonText.fontName = "Chalkduster"
        backButtonText.fontSize = 20
        backButtonText.fontColor = SKColor.white
        backButtonText.position = CGPoint(x: 0, y: -10)
        backButton?.addChild(backButtonText)
        
        if let backButton = backButton {
            addChild(backButton)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if let backButton = backButton, backButton.contains(touchLocation) {
            backButton.removeFromParent()
            gameOverLabel?.removeFromParent()
            
            isGameOver = false
            score = 0
            
            addChild(player)
            player.position = CGPoint(x: 100, y: 384)
        }
    }
}
