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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageToLoad = selectedImage {
            let fileURL = FileManagerHelper.getDocumentsDirectory().appendingPathExtension(imageToLoad)
            imageView.image = UIImage(contentsOfFile: fileURL.path)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
