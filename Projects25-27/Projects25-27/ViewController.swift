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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
    
    //código que coloca o texto na imagem com core graphics
    func setTopTitle(image: UIImage, stringTop: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let renderedImage = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue", size: 100)!,
                .paragraphStyle: paragraphStyle
            ]
            
            let margin = 32
            let textWidth = Int(image.size.width) - (margin * 2)
            let textHeight = Int(image.size.height) - (margin * 2)
            let textRect = CGRect(x: margin, y: margin, width: textWidth, height: textHeight)
            stringTop.draw(in: textRect, withAttributes: attrs)
        }
        
        return renderedImage
    }
    
    func setBottomTitle(image: UIImage, stringBottom: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let renderedImage = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue", size: 100)!,
                .paragraphStyle: paragraphStyle
            ]
            
            let margin = 32
            let textWidth = Int(image.size.width) - (margin * 2)
            let textHeight = 100
            let textRect = CGRect(x: margin, y: Int(image.size.height) - textHeight - margin, width: textWidth, height: textHeight)
            stringBottom.draw(in: textRect, withAttributes: attrs)
        }
        
        return renderedImage
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Unable to share")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    //ação do botão que adiciona o texto acima
    @IBAction func setTopAction(_ sender: Any) {
        guard let image = currentImage else { return }
        
        let ac = UIAlertController(title: "Add a set text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] _ in
            guard let self = self, var string = ac.textFields?.first?.text else { return }
            self.currentImage = self.setTopTitle(image: image, stringTop: string)
            self.imageView.image = self.currentImage
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    //ação do botão que adiciona o texto abaixo
    @IBAction func setBottomAction(_ sender: Any) {
        guard let image = currentImage else { return }
        
        let ac = UIAlertController(title: "Add a bottom text", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {[weak self] _ in
            guard let self = self, var string = ac.textFields?.first?.text else { return }
            self.currentImage = self.setBottomTitle(image: image, stringBottom: string)
            self.imageView.image = self.currentImage
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

