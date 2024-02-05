import UIKit

// MARK: - ReleaseView Protocol

protocol dateView {
    func setDate(date: String)
    var setDateClosure: ((String) -> Void)? { get set }
}

// MARK: - ReleaseViewModel

final class dateViewModel: dateView {
    var setDateClosure: ((String) -> Void)?
    
    func setDate(date: String) {
        setDateClosure?(date)
    }
}
