//
//  DetailViewController.swift
//  Projects10-12
//
//  Created by leticia.dayane on 04/03/24.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedImage: String?
    var selectedSubtitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let subtitle = selectedSubtitle {
            title = subtitle
        }
        
        if let imageToLoad = selectedImage {
            let fileURL = FileManagerHelper.getDocumentsDirectory().appendingPathExtension(imageToLoad)
            imageView.image = UIImage(contentsOfFile: fileURL.path)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func deleteButtonTapped() {
        if let imageToLoad = selectedImage, let subtitle = selectedSubtitle {
            let documentsDirectory = FileManagerHelper.getDocumentsDirectory()
            let imageURL = documentsDirectory.appendingPathExtension(imageToLoad)
            
            if let index = navigationController?.viewControllers.firstIndex(where: {$0 is ViewController}) {
                if let vc = navigationController?.viewControllers[index] as? ViewController {
                    if let pictureIndex = vc.pictures.firstIndex(where: { $0.image == imageToLoad && $0.caption == subtitle}) {
                        vc.pictures.remove(at: pictureIndex)
                        vc.save()
                    }
                }
            }
            
            do {
                try FileManager.default.removeItem(at: imageURL)
                
                navigationController?.popViewController(animated: true)
            } catch {
                print("Error to delete image.")
            }
        }
    }


}
