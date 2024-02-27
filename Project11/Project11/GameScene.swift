//
//  GameScene.swift
//  Project11
//
//  Created by leticia.dayane on 23/02/24.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var scoreLabel: SKLabelNode!
    var editLabel: SKLabelNode!
    var remainingBallsLabel: SKLabelNode!
    var resultLabel: SKLabelNode!
    var totalBoxCount = 0
    var restartGame: SKLabelNode!
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    
    var remainingBalls = 5 {
        didSet {
            remainingBallsLabel.text = "Balls: \(remainingBalls)"
        }
    }
    
    override func didMove(to view: SKView) {
        //adicionando plano de fundo
        let background = SKSpriteNode(imageNamed: "rainbow")
        
        //obter tamanho da tela do ipad
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        background.size = CGSize(width: screenWidth, height: screenHeight)
        background.position = CGPoint(x: screenWidth / 2, y: screenHeight / 2) //definir para centro da tela
        background.blendMode = .replace
        background.zPosition = -1 //para deixar o plano de fundo atrás sempre
        addChild(background)
        
        remainingBallsLabel = SKLabelNode(fontNamed: "Chalkduster")
        remainingBallsLabel.text = "Balls: \(remainingBalls)"
        remainingBallsLabel.horizontalAlignmentMode = .right
        remainingBallsLabel.position = CGPoint(x: 560, y: 700)
        remainingBallsLabel.fontColor = UIColor.black
        addChild(remainingBallsLabel)
        
        resultLabel = SKLabelNode(fontNamed: "Chalkduster")
        resultLabel.text = ""
        resultLabel.horizontalAlignmentMode = .center
        resultLabel.position = CGPoint(x: 540, y: 540)
        addChild(resultLabel)
        
        restartGame = SKLabelNode(fontNamed: "Chalkduster")
        restartGame.text = "Restart"
        restartGame.position = CGPoint(x: 100, y: 100)
        restartGame.fontColor = UIColor.black
        addChild(restartGame)
        
        //colocando um peso na caixa
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        physicsWorld.contactDelegate = self
        
        //cria os obstáculos
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
        
        //cria os lotes bons e ruins
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
        //mostrando pontuação
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.fontColor = UIColor.black
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        //label de edição
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.fontColor = UIColor.black
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        makeRandomBoxes(number: 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            //isso da uma lista dos nós no ponto em que foram tocados
            let objects = nodes(at: location)
            
            if objects.contains(editLabel) {
                editingMode.toggle()
            } else {
                if editingMode {
                    makeRandomBoxes(number: 15)
                } else {
                    let randomNumber = Int.random(in: 1...7)
                    var colorBall = ""
                    
                    switch randomNumber {
                    case 1:
                        colorBall = "ballBlue"
                    case 2:
                        colorBall = "ballCyan"
                    case 3:
                        colorBall = "ballGreen"
                    case 4:
                        colorBall = "ballGrey"
                    case 5:
                        colorBall = "ballPurple"
                    case 6:
                        colorBall = "ballRed"
                    case 7:
                        colorBall = "ballYellow"
                    default:
                        break
                    }
                    
                    if remainingBalls > 0 {
                        let ball = SKSpriteNode(imageNamed: colorBall)
                        
                        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                        ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
                        ball.physicsBody?.restitution = 0.4
                        ball.position = CGPoint(x: location.x, y: 700)
                        ball.name = "ball"
                        addChild(ball)
                    }
                    
                }
                
                if objects.contains(restartGame) {
                    newGame()
                }
            }
        }
    }
    
    func newGame() {
        remainingBalls = 5
        
        resultLabel.text = ""
        
        for node in children {
            if node.name == "box" || node.name == "ball" {
                node.removeFromParent()
            }
        }
        
        makeRandomBoxes(number: 10)
    }
    
    func makeRandomBoxes(number: Int) {
        for _ in 1...number {
            let size = CGSize(width: Int.random(in: 16...128), height: 16)
            let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
            let location = CGPoint(x: CGFloat.random(in: 128...896), y: CGFloat.random(in: 200...658))
            box.zRotation = CGFloat.random(in: 0...3)
            box.position = location
            
            box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
            box.physicsBody?.isDynamic = false
            box.name = "box"
            totalBoxCount = number
            
            addChild(box)
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    //verifica se o slot é bom ou não
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        
        addChild(slotBase)
        addChild(slotGlow)
        
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "box" {
            object.removeFromParent()
            totalBoxCount -= 1
        }
        
        if object.name == "good" {
            destroyBall(ball: ball)
            score += 1
            result()
        } else if object.name == "bad" {
            destroyBall(ball: ball)
            score -= 1
            remainingBalls -= 1
            result()
        }
    }
    
    func result() {
        if totalBoxCount == 0 {
            resultLabel.fontColor = UIColor.green
            resultLabel.text = "VICTORY!"
        } else if remainingBalls == 0 {
                resultLabel.fontColor = UIColor.red
                resultLabel.text = "DEFEAT :/"
            }
        }
    
    //checa se ainda tem caixa no jogo
    func remainingBoxes() -> Bool {
        for node in children {
            if node.name == "box" {
                return true
            }
        }
        return false
    }
    
    func destroyBall(ball: SKNode) {
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
