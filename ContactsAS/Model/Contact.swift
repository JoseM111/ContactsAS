import Foundation
import CloudKit

class Contact {
    // MARK: @Properties
    var name: String
    var phoneNumber: String?
    var email: String?
    
    // MARK: @Property-CloudKit
    var recordID: CKRecord.ID
    
    // Primary Initializer
    init(name: String, phoneNumber: String?, email: String?, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.recordID = recordID
        
    }


    
    
}// END OF CLASS
