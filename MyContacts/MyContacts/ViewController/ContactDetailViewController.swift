//
//  ContactDetailViewController.swift
//  MyContacts
//
//  Created by Carlotta Chen on 2/11/22.
//

import UIKit

class ContactDetailViewController: UIViewController {

    @IBOutlet weak var nameFieldLabel: UITextField!
    @IBOutlet weak var phoneNumberFieldLabel: UITextField!
    @IBOutlet weak var emailFieldLabel: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameFieldLabel.text,
              let phoneNumber = phoneNumberFieldLabel.text,
              let email = emailFieldLabel.text, !name.isEmpty else { return }
        
        if let contact = contact {
            contact.name = name
            contact.phoneNumber = phoneNumber
            contact.email = email
            ContactController.shared.update(contact: contact) { success in
                switch success {
                case .success(_):
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)
                        print("Successfully updated Contact")
                    }
                case .failure(_):
                    print("Could not update contact")
                }
            }
        } else {
            ContactController.shared.saveContact(with: name, phoneNumber: phoneNumber, email: email) { success in
                if success {
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)
                        print("Successfully saved new Contact")
                    }
                }
            }
        }
    }
    
    func updateViews() {
        guard let contact = contact else { return }
        
        nameFieldLabel.text = contact.name
        phoneNumberFieldLabel.text = contact.phoneNumber
        emailFieldLabel.text = contact.email
    }
    
}
