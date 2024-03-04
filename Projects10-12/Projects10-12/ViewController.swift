//
//  ViewController.swift
//  Projects10-12
//
//  Created by leticia.dayane on 04/03/24.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var images: [String] = []
    var captions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Guard your memories here!"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")
    }
    
    @objc func addNewImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            picker.dismiss(animated: true)
            addImage(image: image)
        }
    }
    
    func addImage(image: UIImage) {
        let vc = UIAlertController(title: "Add subtitle", message: nil, preferredStyle: .alert)
        vc.addTextField { textField in
            textField.placeholder = "Subtitle"
        }
        
        let imagePath = saveImage(image: image)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let text = vc.textFields?.first?.text {
                let imagePath = self?.saveImage(image: image)
                self?.images.append(imagePath ?? "")
                self?.captions.append((text))
                self?.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        vc.addAction(addAction)
        vc.addAction(cancel)
        
        present(vc, animated: true)
    }
    
    func saveImage(image: UIImage) -> String {
        let fileName = UUID().uuidString
        let fileURL = FileManagerHelper.getDocumentsDirectory().appendingPathExtension(fileName)
        if let imageData = image.pngData() {
            try? imageData.write(to: fileURL)
            return fileName
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = captions[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            guard indexPath.row < images.count else { return }
            
            let imageName = images[indexPath.row]
            let subtitle = captions[indexPath.row]
            
            vc.selectedImage = imageName
            vc.selectedSubtitle = subtitle
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

