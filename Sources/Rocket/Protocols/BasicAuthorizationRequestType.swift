import Foundation

// MARK: - Protocol
public protocol BasicAuthorizationRequestType: AuthorizationRequestType {
    var username: String { get }
    var password: String { get }
}

// MARK: - AuthorizationRequestType
extension BasicAuthorizationRequestType {
    public var authorizationKey: String {
        return "Authorization"
    }
    
    public var authroizationValue: String {
        let basic = "Basic "
        let authorization = username + ":" + password
        guard let data = authorization.data(using: .utf8) else {
            return basic
        }
        return basic + data.base64EncodedString()
    }
}
