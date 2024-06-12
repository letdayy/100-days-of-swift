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
    var position: (position: Int, total: Int)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedImage = selectedImage else {
            print("No image provided")
            return
        }
        
        guard let position = position else {
            print("No position provided")
            return
        }
        
        title = selectedImage + " - \(position.position)/\(position.total)"
        
        navigationItem.largeTitleDisplayMode = .never
        
        //colocando o botão da barra de compartilhamento na página de detalhes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
       

            imageView.image = UIImage(named: selectedImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    //criando a função que executa a ação de abrir a barra de compartilhamento
    @objc func shareTapped() {
        //código que exibe as imagens da barra de compartilhamento
        guard let image = imageView.image
        else {
            print("Image not found")
            return
        }
        
        let watermarkedImage = watermark(image: image)
        
        var shareable: [Any] = [watermarkedImage]
        
        if let imageText = selectedImage {
            shareable.append(imageText)
        }
        
        //código que abre a barra de compartilhamento
        //importante colocar o image dentro do array de acitivityItems para funcionar
        let vc = UIActivityViewController(activityItems: shareable, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    func watermark(image: UIImage) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        
        let renderedImage = renderer.image { ctx in
            image.draw(at: CGPoint(x: 0, y: 0))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            let string = "From Storm Viewer"
            
            let attrs: [NSAttributedString.Key: Any] = [
                .strokeWidth: 1.0,
                .strokeColor: UIColor.black,
                .foregroundColor: UIColor.white,
                .font: UIFont(name: "HelveticaNeue", size: 36)!,
                .paragraphStyle: paragraphStyle
            ]
            
            let margin = 32
            let textWidth = Int(image.size.width) - (margin * 2)
            let textHeiht = Int(image.size.height) - (margin * 2)
            string.draw(with: CGRect(x: margin, y: margin, width: textWidth, height: textHeiht), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        
        return renderedImage
    }

}
