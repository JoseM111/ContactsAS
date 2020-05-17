import Foundation

enum ContactError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
    case unexpectedRecordsFound
    case noContactFound
    case unableToEdit
    
    // Give the user whatever information you think they should know. Feel free to write your own descriptions.
    var errorDescription: String {
        switch self {
            case .ckError(let error):
                return error.localizedDescription
            case .couldNotUnwrap:
            return "Unable to get this type..."
        case .unexpectedRecordsFound:
            return "Unexpected records were returned when trying to delete..."
        case .noContactFound:
            return " Could not find new contact..."
            case .unableToEdit:
            return "You are not able to edit this post..."
        }
    }
}

