//
//  ViewController.swift
//  Projects10-12
//
//  Created by leticia.dayane on 04/03/24.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Guard your memories here!"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Picture")
        
        let defaults = UserDefaults.standard
        
        if let savedPictures = defaults.object(forKey: "pictures") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedPictures)
            } catch {
                print("Failed to load pictures.")
            }
        }
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
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let text = vc.textFields?.first?.text {
                let imagePath = self?.saveImage(image: image)
                
                let picture = Picture(image: imagePath ?? "", caption: text)
                
                self?.pictures.append(picture)
                self?.save()
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
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        let picture = pictures[indexPath.row]
        
        cell.textLabel?.text = picture.caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            guard indexPath.row < pictures.count else { return }
            
            let picture = pictures[indexPath.row]
            
            let image = picture.image
            let subtitle = picture.caption
            
            vc.selectedImage = image
            vc.selectedSubtitle = subtitle
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "pictures")
        } else {
            print("Error to save pictures.")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

