//
//  ViewController.swift
//  Projects28-30
//
//  Created by leticia.dayane on 14/06/24.
//

import UIKit

class ViewController: UICollectionViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    /*var backCard = UIImage(named: "back")
    var images: [UIImage] = [UIImage(named: "card1")!, UIImage(named: "card2")!, UIImage(named: "card3")!, UIImage(named: "card4")!, UIImage(named: "card1")!, UIImage(named: "card2")!, UIImage(named: "card3")!, UIImage(named: "card4")!].shuffled()
    var alternateImages: [UIImage] = [UIImage(named: "card1")!, UIImage(named: "card2")!, UIImage(named: "card3")!, UIImage(named: "card4")!, UIImage(named: "card1")!, UIImage(named: "card2")!, UIImage(named: "card3")!, UIImage(named: "card4")!].shuffled()
    var currentImages: [UIImage]*/
    var currentImageNames: [String] = []
    let backImageName = "back"
    let alternateImageNames = ["card1", "card2", "card3", "card4", "card1", "card2", "card3", "card4"].shuffled()
    
    let backImage = UIImage(named: "back")
    
    /*required init?(coder: NSCoder) {
        currentImages = images
        super.init(coder: coder)
    }*/

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        currentImageNames = Array(repeating: backImageName, count: alternateImageNames.count)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentImageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryCell", for: indexPath) as? MemoryCell else { fatalError() }
        //cell.imageView.image = currentImages[indexPath.item]
        //cell.imageView.image = backImage
        
        let imageName = currentImageNames[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        
        /*for currentImage in currentImages {
            cell.imageView.image = backImage
        }*/
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if currentImageNames[indexPath.item] == backImageName {
            currentImageNames[indexPath.item] = alternateImageNames[indexPath.item]
        } else {
            currentImageNames[indexPath.item] = backImageName
        }
        
        /*if currentImages[indexPath.item] == images[indexPath.item] {
            currentImages[indexPath.item] = alternateImages[indexPath.item]
        } else {
            currentImages[indexPath.item] = images[indexPath.item]
        }*/
        collectionView.reloadItems(at: [indexPath])
    }
}

