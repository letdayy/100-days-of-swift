//
//  MemoryCell.swift
//  Projects28-30
//
//  Created by leticia.dayane on 12/06/24.
//

import UIKit

class MemoryCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setupImage() {
        imageView.contentMode = .scaleAspectFit
    }
}
