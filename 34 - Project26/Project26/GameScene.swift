//
//  GameScene.swift
//  Project26
//
//  Created by leticia.dayane on 06/05/24.
//

import CoreMotion
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    var motionManager: CMMotionManager!
    var isGameOver = false
    
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    //challenge 2
    var ended: Int = 0
    
    //challenge 3
    var blackHoles = [CGPoint]()
    
    enum CollisionTypes: UInt32 {
        case player = 1
        case wall = 2
        case star = 4
        case vortex = 8
        case blackhole = 12
        case finish = 16
    }
    
    override func didMove(to view: SKView) {
        addBackgroundAndScore()
        loadLevel(level: "level1")
        createPlayer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager.startAccelerometerUpdates()
        
    }
    
    //extra
    func addBackgroundAndScore() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 30, y: 30)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
    }
    
    //challenge 1
    func typesOfNodes(node: SKSpriteNode, name: String, physicsBody: SKPhysicsBody, categoryBitMask: UInt32, position: CGPoint) {
        node.position = position
        node.name = name
        node.physicsBody = physicsBody
        node.physicsBody?.categoryBitMask = categoryBitMask
        node.physicsBody?.isDynamic = false
        addChild(node)
        
        if node.name == "vortex" {
            node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        }
        
        if node.name == "star" || node.name == "vortex" || node.name == "finish" || node.name == "blackhole" {
            node.physicsBody?.collisionBitMask = 0
            node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        }
    }
    
    func loadLevel(level: String) {
        guard let levelURL = Bundle.main.url(forResource: "\(level)", withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle.")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not load level1.txt in the app bundle.")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                //challenge 1
                if letter == "x" {
                    let node = SKSpriteNode(imageNamed: "block")
                    typesOfNodes(node: node, name: "", physicsBody: SKPhysicsBody(rectangleOf:  node.size), categoryBitMask: CollisionTypes.wall.rawValue, position: position)
                    
                } else if letter == "v" {
                    let node = SKSpriteNode(imageNamed: "vortex")
                    typesOfNodes(node: node, name: "vortex", physicsBody: SKPhysicsBody(circleOfRadius: node.size.width / 2), categoryBitMask: CollisionTypes.vortex.rawValue, position: position)
                    
                } else if letter == "s" {
                    let node = SKSpriteNode(imageNamed: "star")
                    typesOfNodes(node: node, name: "star", physicsBody: SKPhysicsBody(circleOfRadius: node.size.width / 2), categoryBitMask: CollisionTypes.player.rawValue, position: position)
                    
                } else if letter == "f" {
                    let node = SKSpriteNode(imageNamed: "finish")
                    typesOfNodes(node: node, name: "finish", physicsBody: SKPhysicsBody(circleOfRadius: node.size.width / 2), categoryBitMask: CollisionTypes.player.rawValue, position: position)
                    
                } else if letter == "b" {
                    //challenge 3
                    createBlackHole(name: "blackhole", position: position)
                } else if letter == " " {
                    // do nothing!
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
    
    //challenge 3
    func createBlackHole(name: String, position: CGPoint) {
        let node = SKShapeNode(circleOfRadius: 25)
        node.fillColor = .black
        node.name = name
        node.position = position
        node.physicsBody =  SKPhysicsBody(circleOfRadius: 25)
        node.physicsBody?.categoryBitMask = CollisionTypes.blackhole.rawValue
        node.physicsBody?.isDynamic = false
        addChild(node)
        blackHoles.append(position)
    }
    
    func createPlayer() {
        physicsWorld.gravity = .zero
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        addChild(player)
    }
    
    func playerCollided(with node: SKNode) {
        if node.name == "vortex" {
            player.physicsBody?.isDynamic = false
            isGameOver = true
            score -= 1
            
            let move = SKAction.move(to: node.position, duration: 0.25)
            let scale = SKAction.scale(to: 0.0001, duration: 0.25)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            
            player.run(sequence) { [weak self] in
                self?.createPlayer()
                self?.isGameOver = false
            }
        }  else if node.name == "blackhole" {
            //challenge 3
            if let playerPosition = player.position as? CGPoint, let otherBlackHole = blackHoles.first(where: { $0 != node.position }) {
                player.position = otherBlackHole
            }
        } else if node.name == "star" {
            node.removeFromParent()
            score += 1
        } else if node.name == "finish" {
            //challenge 2
                removeAllChildren()
                createPlayer()
                loadLevel(level: "level2")
                ended += 1
                addBackgroundAndScore()
        }
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard isGameOver == false else { return }
        
        #if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x  * 50)
        }
        #endif
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == player {
            playerCollided(with: nodeB)
        } else if nodeB == player {
            playerCollided(with: nodeA)
        }
    }
    
    
}
