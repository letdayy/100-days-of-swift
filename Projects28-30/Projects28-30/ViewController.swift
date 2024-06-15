//
//  ViewController.swift
//  Projects28-30
//
//  Created by leticia.dayane on 14/06/24.
//

import UIKit

class ViewController: UICollectionViewController {
    @IBOutlet weak var imageView: UIImageView!
    var currentImageNames: [String] = []
    let backImageName = "back"
    let alternateImageNames = ["card1", "card2", "card3", "card4", "card1", "card2", "card3", "card4"].shuffled()
    var selectedIndices: [IndexPath] = [] //array para armazenar quantos itens foram selecionados
    var matchedIndices: [IndexPath] = [] //array para armazenar cartas iguais

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
        
        let imageName = currentImageNames[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndices.contains(indexPath) || matchedIndices.contains(indexPath) {
            return
        }
        
        selectedIndices.append(indexPath)
        
        if currentImageNames[indexPath.item] == backImageName {
            currentImageNames[indexPath.item] = alternateImageNames[indexPath.item]
        } else {
            currentImageNames[indexPath.item] = backImageName
        }
        collectionView.reloadItems(at: [indexPath])
        
        if selectedIndices.count == 2 {
            let firstIndex = selectedIndices[0]
            let secondIndex = selectedIndices[1]
            let firstImageName = currentImageNames[firstIndex.item]
            let secondImageName = currentImageNames[secondIndex.item]
            
            if firstImageName == secondImageName {
                matchedIndices.append(contentsOf: selectedIndices)
                equalsCards(firstImageName: firstImageName, secondImageName: secondImageName)
                
            } else {
                diferentCards()
            }
        }
    }
    
    func equalsCards(firstImageName: String, secondImageName: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            for index in self.selectedIndices {
                self.currentImageNames[index.item] = ""
            }
            
            self.collectionView.reloadItems(at: self.selectedIndices)
            self.selectedIndices.removeAll()
        }
    }
    
    func diferentCards() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            
            for index in self.selectedIndices {
                self.currentImageNames[index.item] = self.backImageName
            }
            
            self.collectionView.reloadItems(at: self.selectedIndices)
            self.selectedIndices.removeAll()
        }
    }
}

