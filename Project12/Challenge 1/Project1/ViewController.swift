//
//  ViewController.swift
//  Project1
//
//  Created by leticia.dayane on 28/12/23.
//

import UIKit

class ViewController: UITableViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    
    var pictures = [String]()
    //project 12 challenge 1
    var picturesViewCount = [String: Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //project 12 challenge 1
        let userDefaults = UserDefaults.standard
        picturesViewCount = userDefaults.object(forKey: "ViewCount") as? [String:Int] ?? [String:Int]()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
        if item.hasPrefix("nssl") {
            pictures.append(item)
            
            pictures.sort()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    //código para exibir os nomes das imagens na tela principal
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        //project 12 challenge 1
        cell.detailTextLabel?.text = "Views: \(picturesViewCount[pictures[indexPath.row], default: 0])" //para exibir as visualizações
        
        return cell
    }
    
    //código para abrir a imagem selecionada, exibir o index da imagem e o número total de imagens
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageIndex = indexPath.row + 1
            vc.totalImages = pictures.count
            
            //project 12 challenge 1
            picturesViewCount[pictures[indexPath.row], default: 0] += 1 //cada vez que a imagem for aberta ele vai somar mais 1
            
            saveViewCount()
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
        //project 12 challenge 1
        func saveViewCount() {
            let userDefaults = UserDefaults.standard
            userDefaults.set(picturesViewCount, forKey: "ViewCount")
        }
    }
}

