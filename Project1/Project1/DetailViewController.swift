//
//  DetailViewController.swift
//  Project1
//
//  Created by leticia.dayane on 29/12/23.
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
            imageView.image = UIImage(named: imageToLoad)
        }
        
        //challenge 2 project18
        assert(selectedImage != nil, "Not have a value")
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
