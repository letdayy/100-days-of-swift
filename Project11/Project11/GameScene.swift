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
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
