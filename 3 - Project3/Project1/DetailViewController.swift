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
        
        //colocando o botão da barra de compartilhamento na página de detalhes
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
       

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
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
    
    //criando a função que executa a ação de abrir a barra de compartilhamento
    @objc func shareTapped() {
        //código que exibe as imagens da barra de compartilhamento
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8)
        else {
            print("Image not found")
            return
        }
        
        //código que abre a barra de compartilhamento
        //importante colocar o image dentro do array de acitivityItems para funcionar
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
