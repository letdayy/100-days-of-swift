//
//  MemoryCell.swift
//  Projects28-30
//
//  Created by leticia.dayane on 12/06/24.
//

import UIKit

class MemoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var isFlipped = false
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFit
        flip(to: UIImage(named: "back"), animated: false)
    }
    
    func flip(to image: UIImage?, animated: Bool) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
            imageView.image = image
        
            UIView.transition(with: self.imageView, duration: 0.5, options: transitionOptions, animations: {
                self.imageView.isHidden = false
                self.imageView.image = self.isFlipped ? UIImage(named: "back") : self.imageView.image
            })
        
        isFlipped = !isFlipped
        }
    }
