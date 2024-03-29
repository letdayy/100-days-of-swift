//
//  ViewController.swift
//  Project1
//
//  Created by leticia.dayane on 28/12/23.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
        if item.hasPrefix("nssl") {
            pictures.append(item)
            
            pictures.sort()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath)
        
        if let card = cell as? CardCell {
            card.imageView.image = UIImage(named: pictures[indexPath.row])
        }
                
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = pictures[indexPath.item]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.selectedImage = selectedImage
            
            navigationController?.pushViewController(detailViewController, animated: true)
        }
            }
}

