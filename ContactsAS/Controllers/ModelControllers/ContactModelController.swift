import UIKit
import CloudKit

class ContactModelController {
    // MARK: -Shared instance 🎟
    static let shared = ContactModelController()

    // MARK: -Source of truth 🏦
    var listOfContacts: [Contact] = []

    // MARK: DATABASE PUBLIC
    let publicDB = CKContainer.default().publicCloudDatabase

    // MARK: _@CRUD
    /**©------------------------------------------------------------------------------©*/
    
    // MARK: -CREATE Add method signatures
    func createContactWith(name: String, phoneNumber: String?, email: String?, completion: @escaping (Contact?) -> Void) {
        
        let contactToCreate = Contact(name: name, phoneNumber: phoneNumber, email: email)
        saveContact(contact: contactToCreate) { (success) in
                printf("Contact created & saved successfully")
                self.listOfContacts.append(contactToCreate)

                return completion(contactToCreate)
        }
    }
    
    func saveContact(contact: Contact, completion: @escaping (Contact?) -> Void) {
        
        let contact = CKRecord(contact: contact)
        publicDB.save(contact) { (record, error) in
            
            if let error = error {
                return printf("\(error.localizedDescription) \(error) in function: \(#function)")
            }
            
            guard let record = record,
                let contact = Contact(ckRecord: record)
                else { return }
            
            self.listOfContacts.append(contact)
            completion(contact)
        }
    }
    
    /// READ() if we have data to read
    func fetchAllContacts(completion: @escaping (Result<[Contact]?, ContactError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: ContactKeys.RecordTypeKey, predicate: predicate)
        
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            
            if let error = error {
                printf("\(error.localizedDescription) \(error) in function: \(#function)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let records = records else { return }
            let contacts = records.compactMap { Contact(ckRecord: $0) }
            
            self.listOfContacts = contacts
            completion(.success(contacts))
        }
    }
    
    // MARK: -UPDATE Add method signatures
    func updateContact(contact: Contact, withName name: String, phoneNumber: String?, email: String?, completion: @escaping (Contact?) -> Void) {
        
        contact.name = name
        contact.phoneNumber = phoneNumber
        contact.email = email
        
        let record = CKRecord(contact: contact)
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsCompletionBlock = { (records, _, error) in
            completion(contact)
        }
        
        self.publicDB.add(operation)
    }
    
    // MARK: -DELETE Add method signatures
    func deleteContact(contact: Contact, completion: @escaping (Bool) -> Void) {
        
        let recordID = contact.recordID
        publicDB.delete(withRecordID: recordID) { (_, error) in
            
            if let error = error {
                printf("\(error.localizedDescription) \(error) in function: \(#function)")
                return completion(false)
            }
            
            guard let index = self.listOfContacts.firstIndex(of: contact) else { return }
            self.listOfContacts.remove(at: index)
        }
    }
    /**©------------------------------------------------------------------------------©*/

}
