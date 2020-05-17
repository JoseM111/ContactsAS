import Foundation
import CloudKit

extension Contact: Equatable {
    
    // MARK: _@Failable convenience init?
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactKeys.NameKey] as? String,
              let phoneNumber = ckRecord[ContactKeys.PhoneNumberKey] as? String,
              let email = ckRecord[ContactKeys.EmailKey] as? String
                else { return nil }

        self.init(name: name, phoneNumber: phoneNumber, email: email, recordID: ckRecord.recordID)
    }
    
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        lhs === rhs
    }
}
