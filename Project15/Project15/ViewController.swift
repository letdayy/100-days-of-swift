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

    @IBAction func tapped(_ sender: UIButton) {
        sender.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 3, animations: {
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                
            case 1:
                self.imageView.transform = .identity
                
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -200)
                
            case 3:
                self.imageView.transform = .identity
                
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                
            case 5:
                self.imageView.transform = .identity
                
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = UIColor.white
                
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = UIColor.clear
            
            default:
                break
            }
        }) {
            finished in
            sender.isHidden = false
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

