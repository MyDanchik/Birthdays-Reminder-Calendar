import UIKit

// MARK: - ReleaseView Protocol

protocol ReleaseView {
    func setRelease(release: String)
    var setReleaseClosure: ((String) -> Void)? { get set }
}

// MARK: - ReleaseViewModel

final class ReleaseViewModel: ReleaseView {
    var setReleaseClosure: ((String) -> Void)?
    
    func setRelease(release: String) {
        setReleaseClosure?(release)
    }
}
