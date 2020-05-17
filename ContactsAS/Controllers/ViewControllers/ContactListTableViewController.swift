import UIKit

class ContactListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContactModelController.shared.fetchAllContacts { (contacts) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    // MARK: - Table view data source
    /**©------------------------------------------------------------------------------©*/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ContactModelController.shared.listOfContacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        
        // Get a contact object
        let contact = ContactModelController.shared.listOfContacts[indexPath.row]
        // Bind our subtitle with our model properties
        cell.textLabel?.text = contact.name
        cell.detailTextLabel?.text = contact.phoneNumber
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            // Get a contact object
            let contact = ContactModelController.shared.listOfContacts[indexPath.row]
            
            // Call our delete function From ContactModelController
            ContactModelController.shared.deleteContact(contact: contact) { (success) in
                if success {
                    printf("Contact deleted successfully...")
                }
            }
            
            ContactModelController.shared.listOfContacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? ContactDetailViewController else { return }
            
            let contact = ContactModelController.shared.listOfContacts[indexPath.row]
            destinationVC.contact = contact
        }
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS
