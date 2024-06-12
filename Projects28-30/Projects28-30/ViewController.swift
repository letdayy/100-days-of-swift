//
//  ViewController.swift
//  Projects28-30
//
//  Created by leticia.dayane on 12/06/24.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var cards = [UIImage]()
    var flippedIndices = [IndexPath]()
    var matchedCards = Set<IndexPath>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupCards()
    }
    
    func setupCards() {
        let cardImages = ["card1", "card2", "card3", "card4"].compactMap { UIImage(named: $0)}
        cards = cardImages + cardImages
        cards.shuffle()
    }
    
    func checkForMatch() {
        guard flippedIndices.count == 2 else { return }
        
        let firstCard = cards[flippedIndices[0].item]
        let secondCard = cards[flippedIndices[1].item]
        
        if firstCard == secondCard {
            matchedCards.insert(flippedIndices[0])
            matchedCards.insert(flippedIndices[1])
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                for indexPath in self.flippedIndices {
                    if let cell = self.collectionView.cellForItem(at: indexPath) as? MemoryCell {
                        cell.imageView.image = UIImage(named: "back")?.resize(to: CGSize(width: 140, height: 140))
                    }
                }
            }
        }
        flippedIndices.removeAll()
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoryCell", for: indexPath) as! MemoryCell
        cell.setupImage()
        let cardImage = matchedCards.contains(indexPath) ? cards[indexPath.item] : UIImage(named: "back")?.resize(to: CGSize(width: 140, height: 140))
        cell.imageView.image = cardImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !flippedIndices.contains(indexPath), !matchedCards.contains(indexPath) else {
            return
        }
        
        if let cell = collectionView.cellForItem(at: indexPath) as? MemoryCell {
            cell.flip(to: cards[indexPath.item], animated: true)
            flippedIndices.append(indexPath)
        }
        
        if flippedIndices.count == 2 {
            checkForMatch()
        }

    }
}

