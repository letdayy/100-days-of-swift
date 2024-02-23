//
//  GameScene.swift
//  Project11
//
//  Created by leticia.dayane on 23/02/24.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        //adicionando plano de fundo
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1 //para deixar o plano de fundo atrás sempre
        addChild(background)
        //colocando um peso na caixa
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
            box.position = location
            addChild(box)
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
        }
    }
}
