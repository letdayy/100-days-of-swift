//
//  ViewController.swift
//  Project18
//
//  Created by leticia.dayane on 22/03/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("I'm inside the viewDidLoad() method!")
        
        print(1, 2, 3, 4, separator: "-")
        
        print("Some message", terminator: "")
        
        assert(1 == 1, "Maths failure!")
        //assert(1 == 2, "Maths failure!2")
        
        //assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
        
        for i in 1 ... 100 {
            print("Got a number \(i)")
        }
    }


}

