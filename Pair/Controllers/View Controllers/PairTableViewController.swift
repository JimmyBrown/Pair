//
//  PairTableViewController.swift
//  Pair
//
//  Created by Jimmy on 5/22/20.
//  Copyright © 2020 Jimmy. All rights reserved.
//

import UIKit

class PairTableViewController: UITableViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func addPersonButtonTapped(_ sender: Any) {
        addPersonAlertController()
    }
    
    @IBAction func RandomizeButtonTapped(_ sender: Any) {
        
        PersonController.sharedInstance.randomize()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return PersonController.sharedInstance.pairs.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PersonController.sharedInstance.pairs[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let section = indexPath.section
        let row = indexPath.row
        
        let person = PersonController.sharedInstance.pairs[section][row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let person = PersonController.sharedInstance.pairs[indexPath.section][indexPath.row]
            PersonController.sharedInstance.deletePerson(person: person)
            self.tableView.reloadData()
        }    
    }
    
    func addPersonAlertController() {
        let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.delegate = self
            textField.placeholder = "Full Name"
            textField.keyboardType = .default
            textField.autocapitalizationType = .words
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            
            let person = Person(name: name)
            PersonController.sharedInstance.addPerson(person: person)
            
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
}
