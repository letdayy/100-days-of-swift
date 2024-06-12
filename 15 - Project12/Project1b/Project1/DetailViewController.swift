//
//  DetailViewController.swift
//  Project1
//
//  Created by leticia.dayane on 22/02/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    
    var selectedImage: String?
    var selectedImageIndex: Int?
    var totalImages: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedImageIndex = selectedImageIndex, let totalImages = totalImages {
            title = "Imagem \(selectedImageIndex) de \(totalImages)"
        }
        
        
        
        navigationItem.largeTitleDisplayMode = .never
       

        if let imageToLoad = selectedImage {
            if let image = UIImage(named: imageToLoad) {
                imageView?.image = image
            } else {
                print("Error: image download is failed")
            }
        } else {
            print("Error: nil selectedImage")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
