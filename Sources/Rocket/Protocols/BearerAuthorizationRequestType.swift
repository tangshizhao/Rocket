import Foundation

// MARK: - Protocol
public protocol BearerAuthorizationRequestType: AuthorizationRequestType {
    var token: String? { get }
}

// MARK: - AuthorizationRequestType
extension BearerAuthorizationRequestType {
    public var authorizationKey: String {
        return "Authorization"
    }
    
    public var authroizationValue: String {
        let bearer = "Bearer "
        guard let token = token else {
            return bearer
        }
        return bearer + token
    }
}
