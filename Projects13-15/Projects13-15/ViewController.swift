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
        
        //carregar os dados JSON
        if let path = Bundle.main.path(forResource: "countries", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let result = try decoder.decode([Country].self, from: data)
                self.countries = result
                
                //recarregar após ler os dados
                tableView.reloadData()
            } catch {
                return
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCountry = countries[indexPath.row]
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Detail") as! CountryTableViewController
        detailVC.country = selectedCountry
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

