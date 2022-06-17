//
//  ContactDetailViewController.swift
//  ContactList
//
//  Created by Curt McCune on 6/17/22.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    var contact: Contact?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = contact {
            updateViews(contact: contact)
        }
    }
    
    //MARK: - Helper Functions
    
    func updateViews(contact: Contact) {
        emailTextField.text = contact.email ?? ""
        phoneNumberTextField.text = contact.phoneNumber ?? ""
        nameTextField.text = contact.name
    }
    
    //MARK: - Outlet Functions
    
    @IBAction func nameTFChanged(_ sender: Any) {
        if nameTextField.text != nil && nameTextField.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
    }
    @IBAction func numberTFChanged(_ sender: Any) {
        if nameTextField.text != nil && nameTextField.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func emailTFChanged(_ sender: Any) {
        if nameTextField.text != nil && nameTextField.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    @IBAction func savebuttonTapped(_ sender: Any) {
        
        
        guard let name = nameTextField.text else {return}
        
        
        if let contact = contact {
            
            contact.phoneNumber = phoneNumberTextField.text
            contact.email = emailTextField.text
            contact.name = name
            
            ContactController.shared.modify(contact: contact) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let success):
                        if success {
                            
                            if let index = ContactController.shared.contacts.firstIndex(of: contact) {
                                self.navigationController?.popViewController(animated: true)
                                ContactController.shared.contacts[index].email = contact.email
                                ContactController.shared.contacts[index].phoneNumber = contact.phoneNumber
                                ContactController.shared.contacts[index].name = contact.name
                            }
                        } else {
                            
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        
        
        else {
            ContactController.shared.createContact(name: name,
                                                   email: emailTextField.text,
                                                   phoneNumber: phoneNumberTextField.text)
            { result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
    
    
    
}
