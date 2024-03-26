//
//  GameScene.swift
//  Projects16-18
//
//  Created by leticia.dayane on 26/03/24.
//

import SpriteKit

class GameScene: SKScene {
    
    let targetSpeed = 100.0
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = self.size
        background.zPosition = -1
        addChild(background)
        
        createLines(position: CGPoint(x: size.width / 2, y: size.height * 0.25))
        createLines(position: CGPoint(x: size.width / 2, y: size.height * 0.5))
        createLines(position: CGPoint(x: size.width / 2, y: size.height * 0.75))
        
        
        createTargets(atYPosition: size.height * 0.25)
        createTargets(atYPosition: size.height * 0.5)
        createTargets(atYPosition: size.height * 0.75)
    }
    
    func createLines(position : CGPoint) {
        let line = SKSpriteNode(color: .white, size: CGSize(width: size.width, height: 1))
        line.position = position
        line.zPosition = 0
        addChild(line)
    }
    
    func createTargets(atYPosition yPosition: CGFloat) {
        let target = SKSpriteNode(imageNamed: "target")
        target.size = CGSize(width: 50, height: 50)
        
        let initialX = size.width + target.size.width / 2
        let initialY = yPosition
        target.position = CGPoint(x: initialX, y: initialY)
        target.zPosition = 1
        addChild(target)
        
        
        let moveDistance = size.width + target.size.width
        let moveDuration = TimeInterval(moveDistance / targetSpeed)
        
        let moveRight = SKAction.moveBy(x: -moveDistance, y: 0, duration: moveDuration)
        let moveLeft = SKAction.moveBy(x: moveDistance, y: 0, duration: moveDuration)
        let moveSequence = SKAction.sequence([moveRight, moveLeft])
        let moveForever = SKAction.repeatForever(moveSequence)
        
        target.run(moveForever)
    }
}
