//
//  ViewController.swift
//  Projects25-27
//
//  Created by leticia.dayane on 14/05/24.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var setTopButton: UIButton!
    @IBOutlet weak var setBottomButton: UIButton!
    
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerTitleButton(button: importButton)
        centerTitleButton(button: setTopButton)
        centerTitleButton(button: setBottomButton)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
    }
    
    func centerTitleButton(button: UIButton) {
        button.titleLabel?.textAlignment = .center
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        imageView.image = image
        
        dismiss(animated: true)
        
        currentImage = image
    }


}

