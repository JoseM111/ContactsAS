import Foundation
import CloudKit

extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: ContactKeys.RecordTypeKey, recordID: contact.recordID)

        self.setValue(contact.name, forKey: ContactKeys.NameKey)
        self.setValue(contact.phoneNumber, forKey: ContactKeys.PhoneNumberKey)
        self.setValue(contact.email, forKey: ContactKeys.EmailKey)
    }
}
