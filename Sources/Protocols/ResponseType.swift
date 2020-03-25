import Foundation
import SwiftyJSON

// MARK: - Protocol
public protocol ResponseType: Codable {
    var json: JSON { get }
}

// MARK: - Default Implemention
extension ResponseType {
    public var json: JSON {
        return JSON(self)
    }
}
