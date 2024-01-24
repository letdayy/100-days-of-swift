//
//  ViewController.swift
//  ShoppingList
//
//  Created by leticia.dayane on 24/01/24.
//

import UIKit

class ViewController: UITableViewController {
    var allItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        //botão que limpa a lista de compras
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(confirmAction))

    }
    
    //código de configuração da tabela
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = allItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }


    @objc func addItem() {
        let ac = UIAlertController(title: "Enter the item name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        allItems.insert(item, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func clearItems() {
        allItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    //alerta para confirmar se realmente deseja excluir todos os itens
    @objc func confirmAction() {
        let ac = UIAlertController(title: "Attention!", message: "Are you sure you want to remove all items?", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
            self.clearItems()
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
}

