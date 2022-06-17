//
//  ContactListTableViewController.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    
    //MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    //MARK: - Helper Functions
    
    func fetchPosts() {
        
        
        
        ContactController.shared.fetchPostOperation { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    ContactController.shared.contacts = contacts
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ContactController.shared.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        let contact = ContactController.shared.contacts[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = contact.name
        
        content.secondaryText = contact.phoneNumber ??  ""
        if content.secondaryText == "" {
            content.secondaryText = contact.email ?? ""
        }
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
    
    
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let contact = ContactController.shared.contacts[indexPath.row]
                
                ContactController.shared.delete(contact:contact) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let success):
                            if success {
                                ContactController.shared.contacts.remove(at: indexPath.row)
                                tableView.deleteRows(at: [indexPath], with: .fade)
                                tableView.reloadData()
                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView",
           let destinationVC = segue.destination as? ContactDetailViewController,
           let index = tableView.indexPathForSelectedRow {
            
            destinationVC.contact = ContactController.shared.contacts[index.row]
            
        }
    }
    
} //End Of Class
