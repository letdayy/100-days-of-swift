//
//  ViewController.swift
//  Project15
//
//  Created by leticia.dayane on 13/03/24.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var currentAnimation = 0

    @IBOutlet weak var tapButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "background")
        
        let background = UIImageView(image: backgroundImage)
        background.contentMode = .scaleAspectFill
        background.frame = UIScreen.main.bounds
        
        view.addSubview(background)
        view.sendSubviewToBack(background)
        
        imageView = UIImageView(image: UIImage(named: "bird"))
        imageView.center = CGPoint(x: 600, y: 384)
        view.addSubview(imageView)
        
        layoutConfigure()
    }
    
    func layoutConfigure() {
        tapButton.layer.cornerRadius = 10
    }

    @IBAction func tapped(_ sender: Any) {
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

