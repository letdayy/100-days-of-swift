//
//  ViewController.swift
//  Projects13-15
//
//  Created by leticia.dayane on 15/03/24.
//

import UIKit

class ViewController: UITableViewController {
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries Explorer"
        // Do any additional setup after loading the view.
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }*/
}

