//
//  ViewController.swift
//  Projects25-27
//
//  Created by leticia.dayane on 14/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var importButton: UIButton!
    @IBOutlet weak var setTopButton: UIButton!
    @IBOutlet weak var setBottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centerTitleButton(button: importButton)
        centerTitleButton(button: setTopButton)
        centerTitleButton(button: setBottomButton)
    }
    
    func centerTitleButton(button: UIButton) {
        button.titleLabel?.textAlignment = .center
    }


}

