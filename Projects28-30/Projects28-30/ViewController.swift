//
//  ViewController.swift
//  Projects28-30
//
//  Created by leticia.dayane on 14/06/24.
//

import UIKit

class ViewController: UICollectionViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var images: [UIImage] = [UIImage(named: "card1")!, UIImage(named: "card2")!]
    var alternateImages: [UIImage] = [UIImage(named: "card3")!, UIImage(named: "card4")!]
    var currentImages: [UIImage]
    
    required init?(coder: NSCoder) {
        currentImages = images
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryCell", for: indexPath) as? MemoryCell else { fatalError() }
        cell.imageView.image = currentImages[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if currentImages[indexPath.item] == images[indexPath.item] {
            currentImages[indexPath.item] = alternateImages[indexPath.item]
        } else {
            currentImages[indexPath.item] = images[indexPath.item]
        }
        collectionView.reloadItems(at: [indexPath])
    }
}

