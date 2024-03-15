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
        
        
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Country].self, from: data)
                self.countries = result
            } catch {
                return
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = "Name of country here"
        return cell
    }
    
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }*/
}

