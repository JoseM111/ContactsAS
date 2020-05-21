import UIKit

class ContactDetailViewController: UIViewController {
    // MARK: _@IBOutlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    // MARK: @Property
    var contact: Contact? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    // MARK: -#Life-Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    func updateViews() {
           guard let contact = contact else { return }
           nameTextField.text = contact.name
           phoneNumberTextField.text = contact.phoneNumber
           emailAddressTextField.text = contact.email
       }
    
    // MARK: _@IBAction
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let phoneNumber = phoneNumberTextField.text,
            let email = emailAddressTextField.text else { return }
        
        
        if let contact = contact {
            ContactModelController.shared.updateContact(contact: contact, withName: name, phoneNumber: phoneNumber, email: email) { (success) in
                if success != nil {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated:  true)
                    }
                } else {
                    fatalError("Failed to delete contact...")
                }
            }
        } else {
            ContactModelController.shared.createContactWith(name: name, phoneNumber: phoneNumber, email: email) { (success) in
                if success != nil {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    fatalError("Failed to delete contact...")
                }
            }
        }
    }
}// END OF CLASS
