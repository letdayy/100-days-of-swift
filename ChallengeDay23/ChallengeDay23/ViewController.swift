//
//  ViewController.swift
//  ChallengeDay23
//
//  Created by leticia.dayane on 10/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    var images = [String]()
    //let flags = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix("2x.png") {
                images.append(item)
            }
        }
        
        print(images)
    }
    
}
